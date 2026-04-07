from scr.database.db import *
from scr.model.modelo_base import ModeloBase

CLASES_VALIDAS = ('economica', 'primera')
ESTADOS_VALIDOS = ('disponible', 'ocupado', 'reservado')


class Asiento(ModeloBase):
    __tablename__ = 'asientos'

    def __init__(self, id, avion_id, numero_asiento, clase, estado):
        self._id = id
        self._avion_id = avion_id
        self._numero_asiento = numero_asiento
        self._clase = clase
        self._estado = estado

    # --- GETTERS ---
    @property
    def id(self):
        return self._id

    @property
    def avion_id(self):
        return self._avion_id

    @property
    def numero_asiento(self):
        return self._numero_asiento

    @property
    def clase(self):
        return self._clase

    @property
    def estado(self):
        return self._estado

    # --- SETTERS con validacion ---
    @numero_asiento.setter
    def numero_asiento(self, valor):
        if not valor or len(valor.strip()) < 2:
            raise ValueError('El numero de asiento no es valido. Ej: 1A, 14C')
        self._numero_asiento = valor.strip().upper()

    @clase.setter
    def clase(self, valor):
        if valor not in CLASES_VALIDAS:
            raise ValueError(f'La clase debe ser una de: {CLASES_VALIDAS}')
        self._clase = valor

    @estado.setter
    def estado(self, valor):
        if valor not in ESTADOS_VALIDOS:
            raise ValueError(f'El estado debe ser uno de: {ESTADOS_VALIDOS}')
        self._estado = valor

    # --- Metodos especificos de Asiento ---
    @staticmethod
    def obtener_disponibles(avion_id, clase):
        """Trae los asientos disponibles de un avion segun la clase."""
        connection = get_connection()
        if not connection:
            return []
        try:
            cursor = connection.cursor(dictionary=True)
            sql = '''
                  SELECT * \
                  FROM asientos
                  WHERE avion_id = %s \
                    AND clase = %s \
                    AND estado = 'disponible'
                  ORDER BY numero_asiento ASC \
                  '''
            cursor.execute(sql, (avion_id, clase))
            filas = cursor.fetchall()
            return [Asiento(**fila) for fila in filas]
        finally:
            cursor.close()
            connection.close()

    @staticmethod
    def marcar_ocupado(asiento_id):
        """
        Cambia el estado a 'ocupado'. Retorna True si se actualizo.
        El AND estado='disponible' evita la doble venta.
        """
        connection = get_connection()
        if not connection:
            return False
        try:
            cursor = connection.cursor()
            cursor.execute(
                "UPDATE asientos SET estado='ocupado' WHERE id=%s AND estado='disponible'",
                (asiento_id,)
            )
            connection.commit()
            return cursor.rowcount > 0
        finally:
            cursor.close()
            connection.close()

    def __repr__(self):
        return f'Asiento({self._numero_asiento} - {self._clase} - {self._estado})'