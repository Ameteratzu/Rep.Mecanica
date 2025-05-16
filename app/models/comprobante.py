from app.extensions import db
from datetime import datetime

class Comprobante(db.Model):
    __tablename__ = "comprobantes"
    id = db.Column(db.Integer, primary_key=True)
    serie = db.Column(db.String(4))
    numero = db.Column(db.Integer)
    fecha_emision = db.Column(db.DateTime, default=datetime.utcnow)
    cliente_id = db.Column(db.Integer, db.ForeignKey("clientes.id"), nullable=False)
    orden_id = db.Column(db.Integer, db.ForeignKey("ordenes.id"))
    subtotal = db.Column(db.Numeric(10,2))
    igv = db.Column(db.Numeric(10,2))
    total = db.Column(db.Numeric(10,2))
    forma_pago = db.Column(db.String(30))
    observaciones = db.Column(db.String(255))

    # Relaciones
    cliente = db.relationship("Cliente", backref="comprobantes")
    orden = db.relationship("Orden", backref="comprobantes")
    detalle = db.relationship(
        "ComprobanteDetalle",
        backref="comprobante",
        cascade="all, delete-orphan"
    )

class ComprobanteDetalle(db.Model):
    __tablename__ = "comprobante_detalle"
    id = db.Column(db.Integer, primary_key=True)
    comprobante_id = db.Column(db.Integer, db.ForeignKey('comprobantes.id'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'))
    descripcion = db.Column(db.String(100))
    cantidad = db.Column(db.Integer)
    precio_unitario = db.Column(db.Numeric(10,2))
    total = db.Column(db.Numeric(10,2))

    producto = db.relationship("Producto")

    def __repr__(self):
        return f"<ComprobanteDetalle {self.id} - {self.descripcion} ({self.cantidad})>"
