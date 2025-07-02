from app.extensions import db
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

class User(UserMixin, db.Model):
    __tablename__ = "usuarios"

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(150), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    active = db.Column(db.Boolean, default=True)
    last_login = db.Column(db.DateTime)
    persona_id = db.Column(db.Integer, db.ForeignKey("personas.id"), nullable=False)
    rol_id = db.Column(db.Integer, db.ForeignKey("roles.id"), nullable=False, default=1)

    ventas = db.relationship('Venta', back_populates='usuario', cascade='all, delete-orphan')
    rol = db.relationship('Rol', backref='usuarios')

    def set_password(self, pw):
        self.password_hash = generate_password_hash(pw)

    def check_password(self, pw):
        return check_password_hash(self.password_hash, pw)
