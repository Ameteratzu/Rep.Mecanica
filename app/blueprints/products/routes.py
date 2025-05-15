from flask import render_template, request
from flask_login import login_required
from app.models.producto import Producto
from flask import Blueprint, redirect, url_for, flash
from app.models.categoria import Categoria  # importa el modelo Categoria

products_bp = Blueprint("products", __name__, url_prefix="/productos")

@products_bp.route("/", methods=["GET"])
@login_required
def list_products():
    # Obtener el número de página desde los parámetros de la URL (por defecto: 1)
    page = request.args.get("page", 1, type=int)
    
    # Consultar productos con paginación
    pagination = Producto.query.order_by(Producto.id).paginate(page=page, per_page=10)
    
    # Obtener los productos actuales en la página
    productos = pagination.items

    categorias = Categoria.query.order_by(Categoria.categoria).all()

  
    # Pasar productos y paginación al template
    return render_template("products/list.html", productos=productos, pagination=pagination, categorias=categorias)


@products_bp.route("/crear", methods=["POST"])
@login_required
def create_product():
    codigo = request.form["codigo"]
    nombre = request.form["nombre"]
    marca = request.form["marca"]
    precio = request.form["precio"]
    categoria_id = request.form["categoria_id"]
    activo = "activo" in request.form  # checkbox

    nuevo_producto = Producto(
        codigo=codigo,
        nombre=nombre,
        marca=marca,
        precio=precio,
        categoria_id=categoria_id,
        activo=activo,
    )

    from app.extensions import db
    db.session.add(nuevo_producto)
    db.session.commit()

    flash("Producto agregado exitosamente", "success")
    return redirect(url_for("products.list_products"))