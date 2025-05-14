from werkzeug.security import generate_password_hash, check_password_hash
from flask_login       import UserMixin
from app.extensions    import db

class User(UserMixin, db.Model):
    __tablename__   = "usuarios"   # o "users" si tu tabla se llama así
    id              = db.Column(db.Integer, primary_key=True)
    email           = db.Column(db.String(150), unique=True, nullable=False)
    password_hash   = db.Column(db.String(200), nullable=False)
    active          = db.Column(db.Boolean, default=True, nullable=False)

    def set_password(self, pwd):
        """Hashea y almacena la contraseña."""
        self.password_hash = generate_password_hash(pwd)

    def check_password(self, pwd):
        """Comprueba la contraseña."""
        return check_password_hash(self.password_hash, pwd)
