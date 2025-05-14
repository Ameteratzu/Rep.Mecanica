# app/models/orden.py
from app.extensions import db

class Orden(db.Model):
    __tablename__ = "ordenes"

    id         = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey("clientes.id"), nullable=False)
    fecha      = db.Column(db.DateTime, nullable=False)
    estado     = db.Column(db.String(50), nullable=False)  # coincide con la DB

    # Relación con Cliente
    cliente = db.relationship("Cliente", back_populates="ordenes")

    def __repr__(self):
        return f"<Orden {self.id} – {self.estado}>"
