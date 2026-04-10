from scr.database import *
from scr.model.modelo_base import ModeloBase


class Ciudad(ModeloBase):
    """
    Representa una ciudad. Hereda de ModeloBase los metodos
    obtener_por_id(), obtener_todos() y eliminar_por_id().
    """

    __tablename__ = 'ciudades'

    def __init__(self, id, nombre, codigo_iata, pais):
        self._id = id
        self._nombre = nombre
        self._codigo_iata = codigo_iata
        self._pais = pais

    #--Getter--
    @property
    def id(self):
        return self._id
    @property
    def nombre(self):
        return self._nombre
    @property
    def codigo_iata(self):
        return self._codigo_iata
    @property
    def pais(self):
        return self._pais
    #--Setter--

    @property
    def nombre(self,valor):
        if not valor or len(valor.strip()) < 2:
            raise ValueError('El nombre debe tener al menos 2 caracteres.')
        self._nombre = valor.strip()
    @property
    def codigo_iata(self,valor):
        if not valor or len(valor.strip()) != 3:
            raise ValueError('El codigo IATA debe tener exactamente 3 caracteres.')
        self._codigo_iata = valor.strip().upper()
    @property
    def pais(self,valor):
        if not valor or len(valor.strip()) < 2:
            raise ValueError('El pais debe tener al menos 2 caracteres.')
        self._pais = valor.strip()