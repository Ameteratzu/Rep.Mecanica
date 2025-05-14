# app/models/usuario.py

from werkzeug.security import generate_password_hash, check_password_hash
from flask_login       import UserMixin
from app.extensions    import db

class User(UserMixin, db.Model):
    __tablename__   = "usuarios"
    id              = db.Column(db.Integer, primary_key=True)
    email           = db.Column(db.String(150), unique=True, nullable=False)
    password_hash   = db.Column(db.String(200), nullable=False)
    active          = db.Column(db.Boolean, default=True)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
