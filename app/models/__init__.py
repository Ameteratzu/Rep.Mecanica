# app/models/__init__.py

# Importa todos los modelos para que SQLAlchemy los registre al iniciar la app
from .usuario       import User
from .cliente       import Cliente
from .estado_orden  import EstadoOrden
from .orden         import Orden
from .comprobante   import Comprobante
from .producto      import Producto

# Lista pública de símbolos expuestos
__all__ = [
    "User",
    "Cliente",
    "EstadoOrden",
    "Orden",
    "Comprobante",
    "Producto",
]