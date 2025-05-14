from flask import Blueprint, render_template, request
from flask_login import login_required
from app.models.orden import Orden

orders_bp = Blueprint("orders", __name__, url_prefix="/ordenes")

@orders_bp.route("/", methods=["GET"])
@login_required
def list_orders():
    page     = request.args.get("page", 1, type=int)
    per_page = 10

    pagination = (
        Orden.query
             .order_by(Orden.id.desc())
             .paginate(page=page, per_page=per_page, error_out=False)
    )
    return render_template(
        "orders/list.html",
        orders=pagination.items,
        pagination=pagination
    )
