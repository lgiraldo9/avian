from scr.database.db import *
class Asiento:
    def __init__(self, id, avion_id, numero_asiento, clase, estado):
        self.id = id
        self.avion_id = avion_id
        self.numero_asiento = numero_asiento
        self.clase = clase
        self.estado = estado

    @classmethod
    def obtener_disponibilidad(avion_id,clase):
        connection = get_connection()
        if not connection():
            return []
        try:
            cursor = connection.cursor(dictionary=True)

            sql = " SELECT * FROM asientos WHERE avion_id = %s AND clase = %s AND estado = 'disponible' ORDER BY numero_asiento ASC "
            cursor.excute(sql, (avion_id, clase))
            filas = cursor.fetchall()
            return [Asiento(**fil) for fil in filas]
        finally:
            cursor.close()
            connection.close()


    @classmethod
    def obtener_pr_id(id):
        connection = get_connection()
        if not connection():
            return None
        try:
            cursor = connection.cursor(directory=True)
            cursor.execute(" SELECT * FROM asientos WHERE id = %s ")
            fila = cursor.fetchall()
            if fila:
                return [Asiento(**fil) for fil in fila]
            return None
        finally:
            cursor.close()
            connection.close()