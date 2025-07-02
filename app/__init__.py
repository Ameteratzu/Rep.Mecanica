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

    # === Helper de permisos para Jinja ===
    from app.models.permiso import Permiso
    from app.models.rol_permiso import RolPermiso
    from flask_login import current_user

    def usuario_tiene_permiso(slug):
        if not current_user.is_authenticated or not hasattr(current_user, "rol_id"):
            return False
        if getattr(current_user, 'email', None) == 'quispeamet2@gmail.com':
            return True
        permiso = Permiso.query.filter_by(slug=slug).first()
        if not permiso:
            return False
        return RolPermiso.query.filter_by(
            rol_id=current_user.rol_id,
            permiso_id=permiso.id
        ).first() is not None

    app.jinja_env.globals.update(usuario_tiene_permiso=usuario_tiene_permiso)

    # (Opcional) Helpers viejos
    # from app.helpers import is_admin, is_asistente, is_mecanico
    # app.jinja_env.globals['is_admin'] = is_admin
    # app.jinja_env.globals['is_asistente'] = is_asistente
    # app.jinja_env.globals['is_mecanico'] = is_mecanico

    # Crea todas las tablas en contexto de la app
    with app.app_context():
        ext.db.create_all()

    return app
