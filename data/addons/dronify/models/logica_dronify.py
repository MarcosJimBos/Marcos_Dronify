def calcular_consumo_vuelo(peso_total, es_vip=False):
    """
    Calcula el porcentaje de batería que consumirá el vuelo.
    Lógica:
    - Coste fijo de despegue/aterrizaje: 5%
    - Coste por peso: 1.2% por cada kilo.
    - Descuento VIP: Si el cliente es VIP, el dron va en 'modo ahorro' (10% menos de consumo).
    """
    
    # Consumo base
    consumo = 5.0 + (peso_total * 1.2)
    
    # Aplicar reducción si es VIP (opcional para el ejercicio)
    if es_vip:
        consumo = consumo * 0.9
        
def calcular_consumo_vuelo(peso_total, distancia_total=1.0, riesgo_valor=1, es_vip=False):
    """
    NUEVA LÓGICA DE CONSUMO:
    - Coste fijo despegue/aterrizaje: 5%
    - Coste por peso: 1.2% por cada kilo.
    - Coste por distancia: 0.5% por cada kilómetro.
    - Penalización por Riesgo: el consumo total se incrementa un 10% por cada nivel de riesgo.
      (Ejemplo: Riesgo 1 = +10% -> multiplicador 1.1, Riesgo 5 = +50% -> multiplicador 1.5).
    - Descuento VIP: Si el cliente es VIP, -10% al consumo final total.
    """

    try:
        distancia_total = float(distancia_total or 0)
    except (ValueError, TypeError):
        distancia_total = 1.0

    try:
        riesgo_valor = int(riesgo_valor or 1)
    except (ValueError, TypeError):
        riesgo_valor = 1

    # 1. Consumo base (Fijo + Peso + Distancia)
    consumo = 5.0 + (peso_total * 1.2) + (distancia_total * 0.5)

    # 2. Aplicar multiplicador de riesgo (10% por nivel)
    multiplicador_riesgo = 1 + (riesgo_valor * 0.1)
    consumo = consumo * multiplicador_riesgo

    # 3. Aplicar reducción VIP sobre el total penalizado
    if es_vip:
        consumo = consumo * 0.9

    return round(consumo, 2)

def validar_estado_bateria(bateria_actual, consumo_estimado):
    """
    Verifica si el dron tiene energía suficiente.
    Retorna True si es apto, False si no.
    """
    return bateria_actual >= consumo_estimado