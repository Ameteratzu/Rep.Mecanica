# app/models/cliente.py

from app.extensions import db

class Cliente(db.Model):
    __tablename__ = "clientes"

    id             = db.Column(db.Integer, primary_key=True, autoincrement=True)
    # mapeo de la columna camelCase 'tipoDocumento' a atributo snake_case
    tipo_documento = db.Column('tipoDocumento', db.String(20), nullable=False)

    documento      = db.Column(db.String(20), nullable=False)
    nombres        = db.Column(db.String(100), nullable=False)
    apellidos      = db.Column(db.String(100), nullable=False)
    correo         = db.Column(db.String(120), nullable=True)
    ubigeo_id      = db.Column(db.Integer, db.ForeignKey("ubigeos.id"), nullable=False)
    direccion      = db.Column(db.String(255))
    celular        = db.Column(db.String(15))
    activo         = db.Column(db.Boolean, default=True)

    ubigeo         = db.relationship("Ubigeo", back_populates="clientes")
    automoviles    = db.relationship("Automovil", back_populates="cliente")
    ordenes        = db.relationship("Orden", back_populates="cliente")

    def __repr__(self):
        return f"<Cliente {self.id} – {self.nombres} {self.apellidos}>"
