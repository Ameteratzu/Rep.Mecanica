# app/models/orden.py
from app.extensions import db

class Orden(db.Model):
    __tablename__ = "ordenes"

    id               = db.Column(db.Integer, primary_key=True)
    cliente_id       = db.Column(db.Integer, db.ForeignKey("clientes.id"),      nullable=False)
    fecha            = db.Column(db.Date,                                        nullable=False)
    usuario_id       = db.Column(db.Integer, db.ForeignKey("usuarios.id"),      nullable=False)
    automovil_id     = db.Column(db.Integer, db.ForeignKey("automoviles.id"),   nullable=False)
    descuento        = db.Column(db.Numeric(10, 2),                             nullable=True)
    total            = db.Column(db.Numeric(10, 2),                             nullable=True)
    estado_orden_id  = db.Column(db.Integer, db.ForeignKey("estado_orden.id"),   nullable=False)
    activo           = db.Column(db.Boolean, default=True)
                       
    # Relaciones
    cliente       = db.relationship("Cliente",     back_populates="ordenes")
    usuario       = db.relationship("User",        back_populates="ordenes")      # <- aquí
    automovil     = db.relationship("Automovil",   back_populates="ordenes")
    estado_orden  = db.relationship("EstadoOrden", back_populates="ordenes")

    def __repr__(self):
        return f"<Orden {self.id} – {self.estado_orden_id}>"
