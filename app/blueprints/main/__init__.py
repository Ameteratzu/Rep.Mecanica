def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Inicializar extensiones
    db.init_app(app)

    # Registrar Blueprints
    from app.blueprints.main.routes import main as main_bp
    app.register_blueprint(main_bp)

    return app
