# app/__init__.py

from flask               import Flask
from flask_login         import LoginManager
from itsdangerous        import URLSafeTimedSerializer

from config              import Config
import app.extensions     as ext
from app.extensions      import db, mail

# blueprints
from app.blueprints.main.routes import main as main_bp
from app.blueprints.orders.routes   import orders_bp
from app.blueprints.receipts.routes import receipts_bp
from app.blueprints.products.routes import products_bp
from app.blueprints.products import products as products_bp

# 1) Creamos el LoginManager **fuera** de create_app
login_manager = LoginManager()


def create_app():
    # 2) Aquí dentro creamos la app
    app = Flask(
        __name__,
        template_folder="templates",
        static_folder="static"
    )
    app.config.from_object(Config)

    # Inicializa extensiones
    ext.db.init_app(app)
    ext.mail.init_app(app)
    serializer = URLSafeTimedSerializer(app.config["SECRET_KEY"])
    app.ts = serializer
    
    # 3) Ahora sí vinculamos login_manager con la app
    login_manager.init_app(app)
    login_manager.login_view = "main.login"
    login_manager.login_message_category = "warning"

    # 4) Importa User **después** de haber cargado tus modelos
    from app.models.usuario import User
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # Registra blueprints
    app.register_blueprint(main_bp)
    app.register_blueprint(orders_bp)
    app.register_blueprint(receipts_bp)
    app.register_blueprint(products_bp)

    # Crea tablas que falten
    with app.app_context():
        ext.db.create_all()

    return app
