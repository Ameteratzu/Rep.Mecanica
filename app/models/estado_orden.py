# app/models/estado_orden.py
from app.extensions import db

class EstadoOrden(db.Model):
    __tablename__ = "estadosordenes"
    id           = db.Column(db.Integer, primary_key=True)
    estado_orden = db.Column(db.String(50), nullable=False)
    activo       = db.Column(db.Boolean, default=True)

    # Si lo quieres guardar para más adelante, comenta esto:
    # ordenes = db.relationship("Orden", back_populates="estado")
