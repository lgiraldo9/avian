class Usuario:
    def __init__(self, id, nombre, apellido, password_hash, telefono, fecha_registro, tickets):
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.password_hash = password_hash
        self.telefono = telefono
        self.fecha_registro = fecha_registro
        self.tickets = tickets