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
        orders     = pagination.items,    # paso 'orders' para que coincida con la plantilla
        pagination = pagination
    )

@orders_bp.route("/editar/<int:order_id>", methods=["GET", "POST"])
@login_required
def edit_order(order_id):
    orden = Orden.query.get_or_404(order_id)
    if request.method == "POST":
        # Ejemplo: solo cambiamos el estado
        orden.estado = request.form["estado"]
        db.session.commit()
        flash("Orden actualizada.", "success")
        return redirect(url_for("orders.list_orders", page=request.args.get("page", 1)))
    return render_template("orders/edit.html", orden=orden)


@orders_bp.route("/eliminar/<int:order_id>", methods=["POST"])
@login_required
def delete_order(order_id):
    orden = Orden.query.get_or_404(order_id)
    db.session.delete(orden)
    db.session.commit()
    flash("Orden eliminada.", "warning")
    return redirect(url_for("orders.list_orders"))
