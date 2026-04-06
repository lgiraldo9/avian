class Ticket:

    def __init__(self, id, usuario_id, vuelo_id, asiento_id,
                 clase, precio_pagado, estado, fecha_compra,
                 # Campos extra que vienen de JOINs para mostrar en el HTML
                 numero_vuelo=None, ciudad_origen=None,
                 ciudad_destino=None, fecha_salida=None,
                 numero_asiento=None):
        self.id = id
        self.usuario_id = usuario_id
        self.vuelo_id = vuelo_id
        self.asiento_id = asiento_id
        self.clase = clase
        self.precio_pagado = precio_pagado
        self.estado = estado
        self.fecha_compra = fecha_compra
        # Datos del JOIN para mostrar en "mis tickets"
        self.numero_vuelo = numero_vuelo
        self.ciudad_origen = ciudad_origen
        self.ciudad_destino = ciudad_destino
        self.fecha_salida = fecha_salida
        self.numero_asiento = numero_asiento