# app/__init__.py

from flask               import Flask
from flask_login         import LoginManager
from itsdangerous        import URLSafeTimedSerializer

from config              import Config
import app.extensions     as ext

# blueprints
from app.blueprints.main.routes     import main as main_bp
from app.blueprints.orders.routes   import orders_bp
from app.blueprints.receipts.routes import receipts_bp
from app.blueprints.products.routes import products_bp

# modelo User
from app.models.usuario import User

def create_app():
    # Flask buscará app/templates y app/static
    app = Flask(
        __name__,
        template_folder="templates",
        static_folder="static"
    )
    app.config.from_object(Config)

    # inicializa extensiones
    ext.db.init_app(app)
    ext.mail.init_app(app)
    ext.ts = URLSafeTimedSerializer(app.config["SECRET_KEY"])

    # Flask-Login
    login_manager = LoginManager(app)
    login_manager.login_view = "main.login"
    login_manager.login_message_category = "warning"
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # registra blueprints
    app.register_blueprint(main_bp)
    app.register_blueprint(orders_bp)
    app.register_blueprint(receipts_bp)
    app.register_blueprint(products_bp)

    # crea tablas que falten (no borra nada)
    with app.app_context():
        ext.db.create_all()

    return app
