from odoo import models, fields, api
from odoo.exceptions import ValidationError
from datetime import datetime

from .logica_dronify import calcular_consumo_vuelo


# ==========================================================
# CONTACTOS: CLIENTES Y PILOTOS
# ==========================================================

class ResPartner(models.Model):
    _inherit = "res.partner"

    es_cliente = fields.Boolean(string="¿Es cliente?")
    es_vip = fields.Boolean(string="¿Es cliente VIP?")
    es_piloto = fields.Boolean(string="¿Es piloto?")
    licencia = fields.Char(string="Número de licencia")

    dron_autorizado_ids = fields.Many2many(
        comodel_name="dronify.dron",
        relation="relacion_piloto_dron",
        column1="partner_id",
        column2="dron_id",
        string="Drones autorizados"
    )

    @api.constrains("es_piloto", "licencia")
    def _check_licencia_piloto(self):
        for partner in self:
            if partner.es_piloto and not partner.licencia:
                raise ValidationError(
                    "La licencia es obligatoria si el contacto es piloto."
                )


# ==========================================================
# DRONES
# ==========================================================

class Dron(models.Model):
    _name = "dronify.dron"
    _description = "Gestión de drones"

    name = fields.Char(string="Nombre del dron", required=True)
    capacidad_max = fields.Float(string="Capacidad máxima (kg)", required=True)
    bateria = fields.Integer(string="Nivel de batería (%)", default=100)

    estado = fields.Selection(
        selection=[
            ("disponible", "Disponible"),
            ("vuelo", "En vuelo"),
            ("taller", "En taller"),
        ],

        default="disponible",
        string="Estado"

    )

    piloto_autorizado_ids = fields.Many2many(
        comodel_name="res.partner",
        relation="relacion_piloto_dron",
        column1="dron_id",
        column2="partner_id",
        string="Pilotos autorizados"
    )


# ==========================================================
# PAQUETES
# ==========================================================

class Paquete(models.Model):
    _name = "dronify.paquete"
    _description = "Paquetes a transportar"

    codigo = fields.Char(string="Código", readonly=True, copy=False)
    name = fields.Char(string="Descripción", required=True)
    peso = fields.Float(string="Peso (kg)", required=True)

    cliente_id = fields.Many2one(
        comodel_name="res.partner",
        string="Cliente",
        domain=[("es_cliente", "=", True)],
        required=True
    )

    vuelo_id = fields.Many2one(
        comodel_name="dronify.vuelo",
        string="Vuelo asignado",
        readonly=True
    )

    dron_relacionado = fields.Char(
        string="Dron del vuelo",
        related="vuelo_id.dron_id.name",
        readonly=True
    )

    @api.model_create_multi
    def create(self, vals_list):
        for vals in vals_list:
            if not vals.get("codigo"):
                vals["codigo"] = datetime.now().strftime("%Y%m%d%H%M%S")
        return super().create(vals_list)


# ==========================================================
# VUELOS
# ==========================================================

class Vuelo(models.Model):
    _name = "dronify.vuelo"
    _description = "Registro de vuelos"

    codigo = fields.Char(string="Código", readonly=True, copy=False)

    name = fields.Char(
        string="Nombre del vuelo",
        required=True,
        default=lambda self: datetime.now().strftime("%Y%m%d_Vuelo")
    )

    dron_id = fields.Many2one(
        comodel_name="dronify.dron",
        string="Dron",
        required=True
    )

    piloto_id = fields.Many2one(
        comodel_name="res.partner",
        string="Piloto",
        domain=[("es_piloto", "=", True)],
        required=True
    )

    zona_id = fields.Many2one(
        comodel_name="dronify.zona",
        string="Zona de destino",
        required=True
    )

    paquetes_ids = fields.One2many(
        comodel_name="dronify.paquete",
        inverse_name="vuelo_id",
        string="Paquetes"
    )

    preparado = fields.Boolean(string="Preparado")
    realizado = fields.Boolean(string="Realizado")

    peso_total = fields.Float(
        string="Peso total (kg)",
        compute="_compute_peso_total",
        store=True
    )

    consumo_estimado = fields.Float(
        string="Consumo estimado (%)",
        compute="_compute_consumo_estimado",
        store=True
    )

    # ==========================
    # CREATE
    # ==========================

    @api.model_create_multi
    def create(self, vals_list):
        for vals in vals_list:
            if not vals.get("codigo"):
                vals["codigo"] = datetime.now().strftime("%y%m%d%H%M%S")
        return super().create(vals_list)

    # ==========================
    # COMPUTES
    # ==========================

    @api.depends("paquetes_ids.peso")
    def _compute_peso_total(self):
        for vuelo in self:
            vuelo.peso_total = sum(vuelo.paquetes_ids.mapped("peso"))

    @api.depends("peso_total", "piloto_id.es_vip")
    def _compute_consumo_estimado(self):
        for vuelo in self:
            vuelo.consumo_estimado = calcular_consumo_vuelo(
                vuelo.peso_total,
                vuelo.piloto_id.es_vip if vuelo.piloto_id else False
            )

    # ==========================
    # BOTONES 
    # ==========================

    def action_preparar_vuelo(self):
        for vuelo in self:
            vuelo.preparado = True

    def action_desbloquear(self):
        for vuelo in self:
            vuelo.preparado = False

    def action_finalizar_vuelo(self):
        for vuelo in self:
            vuelo.realizado = True
    @api.depends("peso_total", "zona_id.distancia_km", "zona_id.nivel_riesgo", "paquetes_ids.cliente_id.es_vip")
    def _compute_consumo_estimado(self):
        for vuelo in self:
            # Determinar si algún cliente es VIP
            es_vip = any(vuelo.paquetes_ids.mapped("cliente_id.es_vip"))
            peso = vuelo.peso_total or 0.0
            distancia = vuelo.zona_id.distancia_km or 1.0
            riesgo = 1
            if vuelo.zona_id and vuelo.zona_id.nivel_riesgo:
                try:
                    riesgo = int(vuelo.zona_id.nivel_riesgo)
                except (ValueError, TypeError):
                    riesgo = 1
            vuelo.consumo_estimado = calcular_consumo_vuelo(
                peso, distancia, riesgo, es_vip
            )

    def action_preparar_vuelo(self):
        for vuelo in self:
            vuelo._validar_preparacion()
            vuelo.preparado = True
            vuelo.dron_id.estado = "vuelo"

    def action_desbloquear(self):
        for vuelo in self:
            if vuelo.realizado:
                raise ValidationError("No se puede modificar un vuelo ya realizado.")
            vuelo.preparado = False
            vuelo.dron_id.estado = "disponible"

    def action_finalizar_vuelo(self):
        for vuelo in self:
            if not vuelo.preparado:
                raise ValidationError("El vuelo debe estar preparado antes de finalizar.")
            vuelo.realizado = True
            # Descontar batería
            if vuelo.dron_id:
                nueva_bateria = vuelo.dron_id.bateria - vuelo.consumo_estimado
                vuelo.dron_id.bateria = max(0, int(nueva_bateria))
                vuelo.dron_id.estado = "disponible"

    @api.constrains("preparado")
    def _validar_preparacion(self):
        for vuelo in self:
            if vuelo.preparado:
                errores = []
                if not vuelo.dron_id or not vuelo.piloto_id:
                    errores.append("Debe asignar un dron y un piloto.")
                if not vuelo.paquetes_ids:
                    errores.append("Debe asignar al menos un paquete.")
                if vuelo.peso_total > vuelo.dron_id.capacidad_max:
                    errores.append("El peso total supera la capacidad máxima del dron.")
                if vuelo.dron_id.estado != "disponible":
                    errores.append("El dron no está disponible.")
                if vuelo.dron_id.bateria < vuelo.consumo_estimado:
                    errores.append("La batería del dron es insuficiente para el vuelo.")
                if vuelo.dron_id not in vuelo.piloto_id.dron_autorizado_ids:
                    errores.append("El piloto no está autorizado para este dron.")
                if not vuelo.zona_id:
                    errores.append("Debe asignar una zona de destino.")
                if errores:
                    raise ValidationError("\n".join(errores))


# ==========================================================
# ZONAS DE DESTINOS
# ==========================================================

class Zona(models.Model):
    _name = "dronify.zona"
    _description = "Zonas de destino y riesgo"

    name = fields.Char(string="Nombre de la zona", required=True)
    distancia_km = fields.Float(string="Distancia (km)", default=1.0)
    nivel_riesgo = fields.Selection(
        selection=[
            ("1", "Muy bajo"),
            ("2", "Bajo"),
            ("3", "Medio"),
            ("4", "Alto"),
            ("5", "Crítico")
        ],
        string="Nivel de riesgo",
        required=True
    )
    tarifa_base = fields.Float(string="Tarifa base")
