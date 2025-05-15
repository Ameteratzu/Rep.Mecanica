from app.extensions import db
from datetime import datetime

class Orden(db.Model):
    __tablename__ = 'ordenes'

    id              = db.Column(db.Integer, primary_key=True)
    cliente_id      = db.Column(db.Integer, db.ForeignKey('clientes.id'), nullable=False)
    fecha           = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    numero          = db.Column(db.String(50), nullable=False)
    usuario_id      = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    automovil_id    = db.Column(db.Integer, db.ForeignKey('automoviles.id'), nullable=False)
    descuento       = db.Column(db.Numeric(10, 2), nullable=True)
    total           = db.Column(db.Numeric(10, 2), nullable=False, default=0.00)
    estado_orden_id = db.Column(db.Integer, db.ForeignKey('estadosordenes.id'), nullable=False)
    activo          = db.Column(db.Boolean, default=True)
    estado          = db.Column(db.String(50), nullable=False)

    cliente         = db.relationship('Cliente', back_populates='ordenes', lazy=True)
    usuario         = db.relationship('User', back_populates='ordenes', lazy=True)
    automovil       = db.relationship('Automovil', back_populates='ordenes', lazy=True)
    estado_orden = db.relationship('EstadoOrden', back_populates='ordenes', lazy=True)

    servicios       = db.relationship("OrdenServicio", backref="orden", cascade="all, delete-orphan")
    productos       = db.relationship("OrdenProducto", backref="orden", cascade="all, delete-orphan")

    def agregar_servicio(self, servicio_id, cantidad):
        self.servicios.append(
            OrdenServicio(servicio_id=servicio_id, cantidad=cantidad)
        )

    def agregar_producto(self, producto_id, cantidad):
        self.productos.append(
            OrdenProducto(producto_id=producto_id, cantidad=cantidad)
        )


class OrdenServicio(db.Model):
    __tablename__ = "ordenes_servicios"

    id          = db.Column(db.Integer, primary_key=True)
    orden_id    = db.Column(db.Integer, db.ForeignKey("ordenes.id"), nullable=False)
    servicio_id = db.Column(db.Integer, db.ForeignKey("servicios.id"), nullable=False)
    cantidad    = db.Column(db.Integer, nullable=False)

    servicio    = db.relationship("Servicio")


class OrdenProducto(db.Model):
    __tablename__ = "ordenes_productos"

    id          = db.Column(db.Integer, primary_key=True)
    orden_id    = db.Column(db.Integer, db.ForeignKey("ordenes.id"), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey("productos.id"), nullable=False)
    cantidad    = db.Column(db.Integer, nullable=False)

    producto    = db.relationship("Producto")
