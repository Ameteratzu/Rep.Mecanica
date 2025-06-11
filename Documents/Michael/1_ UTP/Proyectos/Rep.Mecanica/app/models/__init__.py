from app.extensions import db

from .usuario       import User
from .cliente       import Cliente
from .estado_orden  import EstadoOrden
from .automovil     import Automovil
from .categoria     import Categoria
from .producto      import Producto
from .servicio      import Servicio
from .orden         import Orden
from .comprobante   import Comprobante
from .persona       import Persona
from .proveedor     import Proveedor
from .producto_proveedor import ProductoProveedor
from .ingreso import Ingreso
from .ingreso_producto import IngresoProducto
from .inventario import Inventario

__all__ = [
    "db",
    "User",
    "Cliente",
    "EstadoOrden",
    "Automovil",
    "Categoria",
    "Producto",
    "Servicio",
    "Orden",
    "Comprobante",
    "Persona",
    "Proveedor",
    "ProductoProveedor",
    "Ingreso",
    "IngresoProducto",
    "Inventario"
]
