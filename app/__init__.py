from flask import Flask
from flask_login import LoginManager
from itsdangerous import URLSafeTimedSerializer

from config import Config
import app.extensions as ext
from app.blueprints.main.routes import main as main_bp  # Blueprint principal
from app.models import User                            # Modelo User exportado en models/__init__.py


def create_app():
    # Inicializa la aplicación Flask apuntando a las carpetas de plantillas y estáticos
    app = Flask(
        __name__,
        template_folder='templates',
        static_folder='static'
    )
    app.config.from_object(Config)

    # Inicializa extensiones
    ext.db.init_app(app)
    ext.mail.init_app(app)
    ext.ts = URLSafeTimedSerializer(app.config['SECRET_KEY'])

    # Configura Flask-Login
    login_manager = LoginManager()
    login_manager.init_app(app)
    login_manager.login_view = 'main.login'
    login_manager.login_message_category = 'warning'

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # Registra el blueprint principal
    app.register_blueprint(main_bp)

    # Crea las tablas definidas en los modelos si no existen
    with app.app_context():
        ext.db.create_all()

    return app
