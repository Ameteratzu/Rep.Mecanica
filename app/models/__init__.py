# Rep.Mecanica/app/models/__init__.py

from .usuario     import User
from .orden       import Orden
# from .vehiculo    import Vehiculo  # desactiva si no lo usas aún
from .comprobante import Comprobante
from .producto    import Producto

__all__ = [
    "User",
    "Orden",
    # "Vehiculo",
    "Comprobante",
    "Producto",
]
