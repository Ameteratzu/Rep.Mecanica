from flask import (
    Blueprint, render_template, request,
    redirect, url_for, flash
)
from flask_login import login_required, current_user
from datetime import date
from app.extensions import db
from app.models.orden        import Orden
from app.models.estado_orden import EstadoOrden
from app.models.cliente      import Cliente
from app.models.automovil    import Automovil
from app.models.producto     import Producto
from app.models.servicio     import Servicio

orders_bp = Blueprint("orders", __name__, url_prefix="/ordenes")


@orders_bp.route("/", methods=["GET"])
@login_required
def list_orders():
    page     = request.args.get("page", 1, type=int)
    per_page = 10

    # consulta paginada de órdenes
    pagination = (
        Orden.query
             .order_by(Orden.id.desc())
             .paginate(page=page, per_page=per_page, error_out=False)
    )

    # estados para el modal
    estados = EstadoOrden.query.filter_by(activo=True).all()

    return render_template(
        "orders/list.html",
        orders     = pagination.items,
        pagination = pagination,
        estados    = estados
    )


@orders_bp.route("/create", methods=["POST"])
@login_required
def create_order():
    try:
        # 1) datos principales
        estado_id    = int(request.form["estado_orden"])
        nro_orden    = request.form["nro_orden"].strip()
        cliente_id   = int(request.form["cliente_id"])
        automovil_id = int(request.form["automovil_id"])

        # 2) crea la orden con fecha y usuario actual
        orden = Orden(
            cliente_id      = cliente_id,
            fecha           = date.today(),
            numero          = nro_orden,
            usuario_id      = current_user.id,
            automovil_id    = automovil_id,
            estado_orden_id = estado_id
        )
        db.session.add(orden)
        db.session.flush()

        # 3) servicios agregados
        for sid, cant in zip(
            request.form.getlist("servicio_id[]"),
            request.form.getlist("servicio_cantidad[]")
        ):
            sid_int = int(sid)
            qty     = int(cant)
            if sid_int and qty > 0:
                orden.agregar_servicio(sid_int, qty)

        # 4) productos agregados
        for pid, cant in zip(
            request.form.getlist("producto_id[]"),
            request.form.getlist("producto_cantidad[]")
        ):
            pid_int = int(pid)
            qty     = int(cant)
            if pid_int and qty > 0:
                orden.agregar_producto(pid_int, qty)

        db.session.commit()
        flash("Orden creada correctamente.", "success")
    except Exception as e:
        db.session.rollback()
        flash(f"No se pudo crear la orden: {e}", "danger")

    return redirect(url_for("orders.list_orders"))

@orders_bp.route("/<int:order_id>/edit", methods=["GET", "POST"])
@login_required
def edit_order(order_id):
    orden = Orden.query.get_or_404(order_id)

    if request.method == "POST":
        # Aquí actualizas los campos según el formulario
        orden.estado_orden_id = int(request.form["estado_orden"])
        db.session.commit()
        flash("Orden actualizada correctamente.", "success")
        return redirect(url_for("orders.list_orders"))

    estados = EstadoOrden.query.filter_by(activo=True).all()
    return render_template("orders/edit.html", orden=orden, estados=estados)

@orders_bp.route("/<int:order_id>/delete", methods=["POST"])
@login_required
def delete_order(order_id):
    orden = Orden.query.get_or_404(order_id)
    try:
        db.session.delete(orden)
        db.session.commit()
        flash("Orden eliminada correctamente.", "success")
    except Exception as e:
        db.session.rollback()
        flash(f"No se pudo eliminar la orden: {e}", "danger")
    return redirect(url_for("orders.list_orders"))

