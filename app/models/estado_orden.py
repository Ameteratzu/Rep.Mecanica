# app/models/estado_orden.py
from app.extensions import db

class EstadoOrden(db.Model):
    __tablename__ = "estado_orden"   # antes era 'estadosordenes' o similar
    id           = db.Column(db.Integer, primary_key=True)
    estado_orden = db.Column(db.String(50), nullable=False)
    activo       = db.Column(db.Boolean, default=True)

    ordenes      = db.relationship("Orden", back_populates="estado_orden")
