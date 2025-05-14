from flask               import Flask
from flask_login         import LoginManager
from itsdangerous        import URLSafeTimedSerializer

from config              import Config
import app.extensions     as ext
from app.routes          import main as main_blueprint

def create_app():
    app = Flask(
        __name__,
        template_folder="app/templates",
        static_folder="app/static"
    )
    app.config.from_object(Config)

    # Inicializa extensiones
    ext.db.init_app(app)
    ext.mail.init_app(app)
    ext.ts = URLSafeTimedSerializer(app.config["SECRET_KEY"])

    # Configura Flask-Login
    login_manager = LoginManager(app)
    login_manager.login_view = "main.login"
    login_manager.login_message_category = "warning"

    from app.models import User
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # Registra tu blueprint
    app.register_blueprint(main_blueprint)

    # Crear tablas (primera ejecución)
    with app.app_context():
        ext.db.create_all()

    return app
