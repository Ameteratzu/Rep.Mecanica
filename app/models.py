from werkzeug.security import generate_password_hash, check_password_hash
from flask_login       import UserMixin
from app.extensions    import db

class User(UserMixin, db.Model):
    __tablename__  = "users"
    id             = db.Column(db.Integer, primary_key=True)
    persona_id     = db.Column("persona_id", db.String(150), nullable=False)
    contraseña     = db.Column("contraseña", db.String(200), nullable=False)
    activo         = db.Column("activo", db.Boolean, default=True)

    @property
    def email(self):
        # Aquí decides: 
        # si persona_id guarda el email, lo retornas; 
        # si no, tendrías que hacer un JOIN con la tabla persona.
        return self.persona_id  

    @email.setter
    def email(self, value):
        self.persona_id = value

    def set_password(self, pwd):
        self.contraseña = generate_password_hash(pwd)

    def check_password(self, pwd):
        return check_password_hash(self.contraseña, pwd)
