# app/__init__.py

from flask import Flask
from itsdangerous import URLSafeTimedSerializer
from config import Config
from app import extensions as ext
from app.routes import register_blueprints

def create_app():
    app = Flask(__name__, template_folder="templates", static_folder="static")
    app.config.from_object(Config)

    # Inicializa extensiones
    ext.db.init_app(app)
    ext.mail.init_app(app)
    ext.login_manager.init_app(app)

    # Configura login_manager
    ext.login_manager.login_view = "main.login"
    ext.login_manager.login_message_category = "warning"

    # Serializer para confirmaciones, recuperación de contraseña, etc.
    app.ts = URLSafeTimedSerializer(app.config["SECRET_KEY"])

    # User loader para Flask-Login
    from app.models.usuario import User
    @ext.login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # Registra los blueprints
    register_blueprints(app)

    # Helpers para Jinja2 (funciones globales para plantillas)
    from app.helpers import is_admin, is_asistente, is_mecanico
    app.jinja_env.globals['is_admin'] = is_admin
    app.jinja_env.globals['is_asistente'] = is_asistente
    app.jinja_env.globals['is_mecanico'] = is_mecanico

    # Crea todas las tablas en contexto de la app
    with app.app_context():
        ext.db.create_all()

    return app
