from app.extensions import db

class Permiso(db.Model):
    __tablename__ = 'permisos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)
    slug = db.Column(db.String(50), nullable=False, unique=True)
    icono = db.Column(db.String(50), nullable=True)
