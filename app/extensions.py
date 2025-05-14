from itsdangerous import URLSafeTimedSerializer

# Inicializamos el serializador en None; luego lo cargaremos desde create_app
ts = None

# Resto de extensiones…
from flask_sqlalchemy import SQLAlchemy
from flask_mail       import Mail

db   = SQLAlchemy()
mail = Mail()
