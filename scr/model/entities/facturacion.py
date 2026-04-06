class Facturacion:
    def __init__(self, id, ticket_id, numero_factura, subtotal,
                 impuesto, total, metodo_pago,
                 codigo_transaccion=None, fecha_pago=None, estado_pago='pagado'):
        self.id = id
        self.ticket_id = ticket_id
        self.numero_factura = numero_factura
        self.subtotal = subtotal
        self.impuesto = impuesto
        self.total = total
        self.metodo_pago = metodo_pago
        self.codigo_transaccion = codigo_transaccion
        self.fecha_pago = fecha_pago
        self.estado_pago = estado_pago