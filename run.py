from app import create_app

app = create_app()

# Si tus blueprints (como pendiente_bp) NO se registran en register_blueprints(app), regístralos aquí:
try:
    from app.routes.pendiente_routes import pendiente_bp
    app.register_blueprint(pendiente_bp)
except ImportError:
    pass  # Si ya lo registras en register_blueprints o aún no tienes el archivo

if __name__ == "__main__":
    import os
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)  # debug=True para ver errores en desarrollo
