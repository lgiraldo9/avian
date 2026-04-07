from scr.database.db import *
from scr.model.modelo_base import ModeloBase

class Ciudad(ModeloBase) \
        __tablename__ = 'ciudades'

    def __init__(self, id, nombre,codigo_iata, pais):
        self.id = id
        self.nombre = nombre
        self.codigo_iata = codigo_iata
        self.pais = pais
    #--Getter
    @property
    def email(self):
        return self._email
