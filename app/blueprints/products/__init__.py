from flask import Blueprint

products = Blueprint(
    'products',
    __name__,
    url_prefix='/productos',
    template_folder='templates/products'
)
from . import routes  # aquí, todas las rutas usan `@products.route(...)`
