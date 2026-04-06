class Vuelos:
    def __init__(self, id, numero_vuelo, avion_id, ciudad_origen_id,
                 ciudad_destino_id, fecha_salida, fecha_llegada,
                 precio_economica, precio_primera, escalas,
                 aerolinea, estado,
                 # Estos campos vienen del JOIN con ciudades (no son columnas de vuelos)
                 ciudad_origen=None, ciudad_destino=None):
        self.id = id
        self.numero_vuelo = numero_vuelo
        self.avion_id = avion_id
        self.ciudad_origen_id = ciudad_origen_id
        self.ciudad_destino_id = ciudad_destino_id
        self.fecha_salida = fecha_salida
        self.fecha_llegada = fecha_llegada
        self.precio_economica = precio_economica
        self.precio_primera = precio_primera
        self.escalas = escalas
        self.aerolinea = aerolinea
        self.estado = estado
        # Nombres de ciudad que traemos con JOIN para mostrar en el HTML
        self.ciudad_origen = ciudad_origen
        self.ciudad_destino = ciudad_destino