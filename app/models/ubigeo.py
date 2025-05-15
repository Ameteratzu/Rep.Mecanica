# app/models/ubigeo.py

from app.extensions import db

class Ubigeo(db.Model):
    __tablename__ = "ubigeos"

    id           = db.Column(db.Integer, primary_key=True, autoincrement=True)
    codigo       = db.Column(db.String(6), nullable=False, unique=True)
    departamento = db.Column(db.String(50), nullable=False)
    provincia    = db.Column(db.String(50), nullable=False)
    distrito     = db.Column(db.String(50), nullable=False)

    # Relación inversa con Cliente (opcional)
    clientes = db.relationship(
        'Cliente',
        back_populates='ubigeo',
        lazy=True
    )

    def __init__(self, codigo, departamento, provincia, distrito):
        self.codigo       = codigo
        self.departamento = departamento
        self.provincia    = provincia
        self.distrito     = distrito

    def __repr__(self):
        return f"<Ubigeo {self.codigo} - {self.departamento}/{self.provincia}/{self.distrito}>"
