from app.extensions import db

class Persona(db.Model):
    __tablename__ = "personas"

    id         = db.Column(db.Integer, primary_key=True)
    documento  = db.Column(db.String(20), unique=True, nullable=False)
    nombres    = db.Column(db.String(100), nullable=False)
    apellidos  = db.Column(db.String(100), nullable=False)
    correo     = db.Column(db.String(120), unique=True, nullable=False)
    rol_id     = db.Column(db.Integer, db.ForeignKey('roles.id'), nullable=False)
    activo     = db.Column(db.Boolean, default=True)

    usuarios   = db.relationship("User", backref="persona", lazy=True)
    rol        = db.relationship("Rol", back_populates="personas")
