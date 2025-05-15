# app/models/cliente.py

from app.extensions import db

class Cliente(db.Model):
    __tablename__ = "clientes"

    id         = db.Column(db.Integer, primary_key=True, autoincrement=True)
    documento  = db.Column(db.String(20), nullable=False)
    nombres    = db.Column(db.String(100), nullable=False)
    apellidos  = db.Column(db.String(100), nullable=False)
    ubigeo_id  = db.Column(db.Integer, db.ForeignKey("ubigeos.id"), nullable=False)
    direccion  = db.Column(db.String(255))
    celular    = db.Column(db.String(15))
    activo     = db.Column(db.Boolean, default=True)

    # Relación con Automóviles
    automoviles = db.relationship("Automovil", back_populates="cliente")

    # Relación con Órdenes
    ordenes = db.relationship('Orden', back_populates='cliente', lazy=True)


    def __repr__(self):
        return f"<Cliente {self.id} – {self.nombres} {self.apellidos}>"
