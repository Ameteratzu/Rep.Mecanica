from app.extensions import db

class Servicio(db.Model):
    __tablename__ = "servicios"

    id          = db.Column(db.Integer, primary_key=True)
    codigo      = db.Column(db.String(20), nullable=False)
    nombre      = db.Column(db.String(100), nullable=False)
    descripcion = db.Column(db.String(200), nullable=False)
    descuento   = db.Column(db.Numeric(10,2), nullable=False)
    precio      = db.Column(db.Numeric(10,2), nullable=False)
    activo      = db.Column(db.Boolean, default=True)
    
    ventas_servicio = db.relationship('VentaServicio', back_populates='servicio', cascade='all, delete-orphan')
