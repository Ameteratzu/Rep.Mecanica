# Rep.Mecanica/app/models/orden.py

from app.extensions import db

class Orden(db.Model):
    __tablename__ = "ordenes"

    id = db.Column(db.Integer, primary_key=True)
    # Referencia al usuario (cliente) en la tabla usuarios
    cliente_id = db.Column(
        db.Integer,
        db.ForeignKey("usuarios.id"),
        nullable=False
    )
    fecha = db.Column(db.DateTime, nullable=False)
    estado = db.Column(db.String(50), nullable=False)

    # Relación con el modelo User
    cliente = db.relationship(
        "User",
        backref="ordenes"
    )

    def __repr__(self):
        return f"<Orden {self.id} - {self.estado}>"
