from flask import Blueprint
from app.routes.cliente_routes import cliente_bp
from app.routes.producto_routes import producto_bp
from app.routes.main_routes import main_bp
from app.routes.proveedor_routes import proveedor_bp
from app.routes.automovil_routes import automovil_bp
from app.routes.ingreso_routes import ingreso_bp
from app.routes.inventario_routes import inventario_bp
from app.routes.servicio_routes import servicio_bp
from app.routes.venta_routes import cotizacion_bp
from app.routes.rol_routes import rol_bp  # <-- AGREGA ESTA LÍNEA

all_blueprints = [
    cliente_bp,
    producto_bp,
    main_bp,
    proveedor_bp,
    automovil_bp,
    ingreso_bp,
    inventario_bp,
    servicio_bp,
    cotizacion_bp,
    rol_bp  # <-- AGREGA AQUÍ
]

def register_blueprints(app):
    for bp in all_blueprints:
        app.register_blueprint(bp)
