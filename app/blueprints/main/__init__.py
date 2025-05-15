from flask import Blueprint

# Definimos aquí el blueprint 'main' y luego lo importamos en routes.py
main = Blueprint(
    'main',
    __name__,
    template_folder='templates',
    static_folder='static'
)

# Importa las rutas para registrarlas en el blueprint
from . import routes  # NO cambies esto por from .routes import main
