from werkzeug.security import generate_password_hash, check_password_hash
from flask_login       import UserMixin
from app.extensions    import db

class User(UserMixin, db.Model):
    __tablename__  = "usuarios"   # o "usuarios" si tu tabla es así
    id             = db.Column(db.Integer, primary_key=True)
    email          = db.Column(db.String(150), unique=True, nullable=False)
    password_hash  = db.Column(db.String(200), nullable=False)
    active         = db.Column(db.Boolean, nullable=False, default=True)

    def set_password(self, pwd):
        self.password_hash = generate_password_hash(pwd)

    def check_password(self, pwd):
        return check_password_hash(self.password_hash, pwd)
