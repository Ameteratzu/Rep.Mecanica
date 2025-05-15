from flask import Blueprint

products = Blueprint(
    'products',               # nombre del endpoint
    __name__,
    url_prefix='/productos',  # <<<< prefijo de ruta
    template_folder='templates/products'
)

from . import routes
