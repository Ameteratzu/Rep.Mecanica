from app.extensions import db

from .usuario       import User
from .cliente       import Cliente
from .automovil     import Automovil
from .categoria     import Categoria
from .producto      import Producto
from .servicio      import Servicio
from .proveedor     import Proveedor
from .producto_proveedor import ProductoProveedor
from .ingreso import Ingreso
from .ingreso_producto import IngresoProducto
from .inventario import Inventario
from .venta import Venta
from .cotizacion_estado import CotizacionEstado
from .venta_producto import VentaProducto
from .venta_servicio import VentaServicio

__all__ = [
    "db",
    "User",
    "Cliente",
    "Automovil",
    "Categoria",
    "Producto",
    "Servicio",
    "Proveedor",
    "ProductoProveedor",
    "Ingreso",
    "IngresoProducto",
    "Inventario",
    "Venta",
    "CotizacionEstado",
    "VentaProducto",
    "VentaServicio"
]
