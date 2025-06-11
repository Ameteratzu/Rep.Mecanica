from flask import Blueprint
from app.routes.cliente_routes import cliente_bp
from app.routes.producto_routes import producto_bp
from app.routes.main_routes import main_bp
from app.routes.proveedor_routes import proveedor_bp
from app.routes.orden_routes import orden_bpp
from app.routes.automovil_routes import automovil_bpp
from app.routes.ingreso_routes import ingreso_bp
from app.routes.inventario_routes import inventario_bp
# importa los demás blueprints que tengas

all_blueprints = [
    cliente_bp,
    producto_bp,
    main_bp,
    proveedor_bp,
    orden_bpp,
    automovil_bpp,
    ingreso_bp,
    inventario_bp
]

def register_blueprints(app):
    for bp in all_blueprints:
        app.register_blueprint(bp)
