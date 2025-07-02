# app/models/automovil.py

from app.extensions import db

class Automovil(db.Model):
    __tablename__ = "automoviles"

    id          = db.Column(db.Integer, primary_key=True, autoincrement=True)
    cliente_id  = db.Column(db.Integer, db.ForeignKey("clientes.id"), nullable=False)
    placa       = db.Column(db.String(10),  nullable=False)
    marca       = db.Column(db.String(50),  nullable=False)
    modelo      = db.Column(db.String(50),  nullable=False)
    año         = db.Column(db.Integer)
    color       = db.Column(db.String(30),  nullable=False)
    activo      = db.Column(db.Boolean, default=True)

    # Relación con Cliente (ya tenías esta)
    cliente     = db.relationship("Cliente",    back_populates="automoviles")
    ventas = db.relationship('Venta', back_populates='automovil')



    def __repr__(self):
        return f"<Automovil {self.id} – {self.placa}>"
