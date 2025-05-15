# app/__init__.py

from flask import Flask
from flask_login import LoginManager
from itsdangerous import URLSafeTimedSerializer
from config import Config
import app.extensions as ext

db = ext.db
mail = ext.mail
login_manager = LoginManager()

def create_app():
    app = Flask(__name__, template_folder="templates", static_folder="static")
    app.config.from_object(Config)

    # Inicializa extensiones
    db.init_app(app)
    mail.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = "main.login"
    login_manager.login_message_category = "warning"
    app.ts = URLSafeTimedSerializer(app.config["SECRET_KEY"])

    # User loader
    from app.models.usuario import User
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # --- BLUEPRINTS: importa y registra UNA VEZ cada uno ---

    # Main
    from app.blueprints.main.routes import main as main_bp
    app.register_blueprint(main_bp)



    # Productos
    from app.blueprints.products import products  # importa el blueprint real
    app.register_blueprint(products)            
    
    from app.blueprints.cliente.routes import cliente_bp
    app.register_blueprint(cliente_bp)  # ya trae url_prefix="/clientes"



    # Órdenes
    from app.blueprints.orders.routes import orders_bp
    app.register_blueprint(orders_bp, url_prefix="/ordenes")

    # Comprobantes
    from app.blueprints.comprobantes.routes import comprobantes_bp
    app.register_blueprint(comprobantes_bp)

    # Recibos
    from app.blueprints.receipts.routes import receipts_bp
    app.register_blueprint(receipts_bp)

    # Crea tablas pendientes
    with app.app_context():
        db.create_all()

    return app
