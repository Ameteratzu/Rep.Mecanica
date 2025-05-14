from flask_sqlalchemy import SQLAlchemy
from flask_mail      import Mail

db   = SQLAlchemy()
mail = Mail()
ts   = None    # se inicializa en run.py con URLSafeTimedSerializer