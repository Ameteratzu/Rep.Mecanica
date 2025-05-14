from flask import Blueprint, render_template, request
from flask_login import login_required, current_user
from app.extensions import db

# IMPORTA AQUÍ TU MODELO DE PRODUCTOS:
from app.models.producto import Producto

products_bp = Blueprint("products", __name__, url_prefix="/productos")

@products_bp.route("/", methods=["GET"])
@login_required
def list_products():
    page = request.args.get("page", 1, type=int)
    per_page = 20

    pagination = (
        Producto.query
                .order_by(Producto.id.asc())
                .paginate(page=page, per_page=per_page, error_out=False)
    )
    return render_template(
        "products/list.html",
        products=pagination.items,
        pagination=pagination
    )
