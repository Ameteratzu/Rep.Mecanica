from app.extensions import db


class VentaServicio(db.Model):
    __tablename__ = 'ventas_servicios'
    
    id = db.Column(db.Integer, primary_key=True)
    venta_id = db.Column(db.Integer, db.ForeignKey('ventas.id'), nullable=False)
    servicio_id = db.Column(db.Integer, db.ForeignKey('servicios.id'), nullable=False)
    
    descripcion = db.Column(db.Text)
    cantidad = db.Column(db.Integer, nullable=False, default=1)
    precio_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    descuento_porcentaje = db.Column(db.Numeric(10, 2), default=0.00)
    descuento_monto = db.Column(db.Numeric(10, 2), default=0.00)
    activo = db.Column(db.Boolean, default=True)

    venta = db.relationship('Venta', back_populates='servicios')
    servicio = db.relationship('Servicio', back_populates='ventas_servicio')
    
    def __repr__(self):
        return f"<VentaServicio {self.id} – Servicio {self.servicio_id}>"
