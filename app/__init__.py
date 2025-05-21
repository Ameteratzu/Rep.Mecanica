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
    
    #Registrar ambos blueprints
    from app.blueprints.admin.roles import roles_bp
    from app.blueprints.admin.usuarios import usuarios_bp
    app.register_blueprint(roles_bp)
    app.register_blueprint(usuarios_bp)

    #Registrar los blueprints
    from app.blueprints.admin.inventario import inventario_bp
    from app.blueprints.admin.servicios import servicios_bp
    app.register_blueprint(inventario_bp)
    app.register_blueprint(servicios_bp)

    # Productos
    from app.blueprints.products import products  # importa el blueprint real
    app.register_blueprint(products)            
    
    from app.blueprints.cliente.routes import cliente_bp
    app.register_blueprint(cliente_bp)  # ya trae url_prefix="/clientes"


    from app.blueprints.admin.routes import admin_panel_bp
    app.register_blueprint(admin_panel_bp)

    # Órdenes
    from app.blueprints.orden.route import orden_bpp
    app.register_blueprint(orden_bpp)

    # automovil
    from app.blueprints.automovil.route import automovil_bpp
    app.register_blueprint(automovil_bpp)

    # Comprobantes
    from app.blueprints.comprobantes.routes import comprobantes_bp
    app.register_blueprint(comprobantes_bp)

    # Recibos
    from app.blueprints.receipts.routes import receipts_bp
    app.register_blueprint(receipts_bp)

    from app.helpers import is_admin, is_asistente, is_mecanico
    app.jinja_env.globals['is_admin'] = is_admin
    app.jinja_env.globals['is_asistente'] = is_asistente
    app.jinja_env.globals['is_mecanico'] = is_mecanico

    # Crea tablas pendientes
    with app.app_context():
        db.create_all()

    return app
