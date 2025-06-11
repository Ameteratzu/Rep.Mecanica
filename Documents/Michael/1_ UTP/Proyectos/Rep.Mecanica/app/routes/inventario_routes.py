from flask import Blueprint, render_template, request
from flask_login import login_required
from app.models.inventario import Inventario
from app.models.producto import Producto
from app.models.proveedor import Proveedor
from app.models.ingreso import Ingreso
from app.models.ingreso_producto import IngresoProducto
from app.extensions import db
from sqlalchemy import func

inventario_bp = Blueprint("inventario", __name__, url_prefix="/inventario")


@inventario_bp.route("/", methods=["GET"])
@login_required
def listar_inventario():
    
    # ✅ Actualiza todo el inventario
    Inventario.actualizar_todo_el_inventario()
        
    page = request.args.get("page", 1, type=int)
    search = request.args.get("search", "").strip()

    query = db.session.query(
        Producto.codigo,
        Producto.nombre,
        Producto.costo,
        func.coalesce(Inventario.total_ingresos, 0).label("total_ingresos"),
        func.coalesce(Inventario.total_egresos, 0).label("total_egresos"),
        func.coalesce(Inventario.stock, 0).label("stock")
    ).outerjoin(Inventario, Inventario.producto_id == Producto.id)

    if search:
        query = query.filter(
            (Producto.codigo.like(f"%{search}%")) |
            (Producto.nombre.like(f"%{search}%"))
        )

    pagination = query.paginate(page=page, per_page=10)
    inventarios = pagination.items

    productos = Producto.query.all()
    proveedores = Proveedor.query.filter_by(activo=True).all()
    guia_tentativa = Ingreso.generar_codigo_guia()
    
    return render_template("inventario_pag/inventario_list.html",
                           inventarios=inventarios,
                           productos=productos,
                           proveedores=proveedores,
                           pagination=pagination,
                           search=search,
                           guia_tentativa=guia_tentativa)


