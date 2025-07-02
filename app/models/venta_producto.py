from app.extensions import db
from sqlalchemy import func
from app.models.venta import Venta

class VentaProducto(db.Model):
    __tablename__ = 'ventas_productos'
    
    id = db.Column(db.Integer, primary_key=True)
    venta_id = db.Column(db.Integer, db.ForeignKey('ventas.id'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False)
    
    descripcion = db.Column(db.Text)
    cantidad = db.Column(db.Integer, nullable=False, default=1)
    precio_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    descuento_porcentaje = db.Column(db.Numeric(10, 2), default=0.00)
    descuento_monto = db.Column(db.Numeric(10, 2), default=0.00)
    costo = db.Column(db.Numeric(10, 2))
    activo = db.Column(db.Boolean, default=True)

    
    venta = db.relationship('Venta', back_populates='productos')
    producto = db.relationship('Producto', back_populates='ventas_producto')
    
    def __repr__(self):
        return f"<VentaProducto {self.id} – Producto {self.producto_id}>"

    @classmethod
    def total_vendido_por_producto(cls, producto_id, estado_pagado_id=7):
        total = (
            db.session.query(func.sum(cls.cantidad))
            .join(Venta)
            .filter(
                cls.producto_id == producto_id,
                cls.activo == True,
                Venta.estado_id == estado_pagado_id
            )
                .scalar()
        )
        return total or 0  # Devuelve 0 si es None