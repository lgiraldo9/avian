import re
from scr.model.modelo_base import ModeloBase
from scr.database.db import *

class Usuario(ModeloBase):
    __tablename__ = 'usuarios'

    def __init__(self, id, nombre, apellido, email,
                 password_hash, telefono=None, fecha_registro=None):
        self.id             = id
        self.nombre         = nombre
        self.apellido       = apellido
        self.email          = email
        self.password_hash  = password_hash
        self.telefono       = telefono
        self.fecha_registro = fecha_registro

        #--Getter--
        @property
        def id(self):
            return self._id
        @property
        def nombre(self):
            return self._nombre
        @property
        def apellido(self):
            return self._apellido
        @property
        def email(self):
            return self._email
        @property
        def password_hash(self):
            return self._password_hash
        @property
        def telefono(self):
            return self._telefono
        @property
        def fecha_registro(self):
            return self._fecha_registro
        #--Setter--
        @nombre.setter
        def nombre(self, valor):
            if not valor or len(valor.strip()) < 2:
                raise ValueError('El nombre debe tener al menos 2 caracteres.')
            self._nombre = valor.strip()

        @apellido.setter
        def apellido(self, valor):
            if not valor or len(valor.strip()) < 2:
                raise ValueError('El apellido debe tener al menos 2 caracteres.')
            self._apellido = valor.strip()

        @email.setter
        def email(self, valor):
            # Validamos que el email tenga formato correcto con una expresion regular
            patron = r'^[\w\.-]+@[\w\.-]+\.\w{2,}$'
            if not valor or not re.match(patron, valor):
                raise ValueError('El email no tiene un formato valido. Ej: usuario@email.com')
            self._email = valor.lower().strip()

        @telefono.setter
        def telefono(self, valor):
            # El telefono es opcional, puede ser None
            if valor and len(valor.strip()) < 7:
                raise ValueError('El telefono debe tener al menos 7 digitos.')
            self._telefono = valor.strip() if valor else None

    # --- Metodos especificos de Usuario ---
    """
    @staticmethod
    def obtener_usuario(usuario_id):
        connection = get_connection()
        if not connection:
            return None
        try:
            cursor = connection.cursor()
            cursor.execute('select * from usuarios where id = %s', (usuario_id,))
            fila = cursor.fetchone()
            if fila :
                return Usuario(**fila)
            return None
        finally:
            cursor.close()
            connection.close()
    """
    @staticmethod
    def obtener_por_emial(email_address):
        connection = get_connection()
        if not connection:
            return None
        try:
            cursor = connection.cursor()
            cursor.execute('select * from Usuarios where email = %s', (email_address,))
            fila = cursor.fetchone()
            if fila:
                return Usuario(**fila)
            return None
        finally:
            cursor.close()
            connection.close()

    @staticmethod
    def crear_usuario(nombre, apellido, email, password_hash, telefono=None):
        connection = get_connection()
        if not connection:
            return None
        try:
            with connection.cursor() as cursor:
                sql = '''
                INSERT INTO usuarios (nombre, apellido, email, password_hash, telefono)
                VALUES (%s, %s, %s, %s, %s)'''
            cursor.execute(sql, (nombre, apellido, email, password_hash, telefono))
            connection.commit()
            return cursor.lastrowid
        finally:
            cursor.close()
            connection.close()


    def __repr__(self):
        return f'Usuario({self._email})'
