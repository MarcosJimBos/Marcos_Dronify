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
        default="disponible"
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

    @api.model
    def create(self, vals):
        if not vals.get("codigo"):
            vals["codigo"] = datetime.now().strftime("%Y%m%d%H%M%S")
        return super().create(vals)


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

    @api.model
    def create(self, vals):
        if not vals.get("codigo"):
            vals["codigo"] = datetime.now().strftime("%y%m%d%H%M%S")
        return super().create(vals)

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
