from app.extensions import db

class Rol(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    rol = db.Column(db.String(50), nullable=False)
    activo = db.Column(db.Boolean, default=True)
    personas = db.relationship('Persona', back_populates='rol')
