from flask import (
    Blueprint, render_template, request,
    redirect, url_for, flash
)
from flask_login import login_required, current_user
from datetime import date
from app.extensions import db
from app.models.estado_orden import EstadoOrden
from app.models.orden        import Orden
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
    pagination = (
        Orden.query
             .order_by(Orden.id.desc())
             .paginate(page=page, per_page=per_page, error_out=False)
    )

    # Traemos los posibles estados desde su tabla
    estados = EstadoOrden.query.filter_by(activo=True).all()

    return render_template(
        "orders/list.html",
        ordenes = pagination.items,
        pagination = pagination,
        estados = estados,
        productos = Producto.query.filter_by(activo=True).all(),
        servicios = Servicio.query.filter_by(activo=True).all(),
    )


@orders_bp.route("/nueva", methods=["POST"])
@login_required
def create_order():
    try:
        estado_text   = request.form["estado"]        # ahora tomamos el texto
        nro_orden     = request.form["nro_orden"].strip()
        cliente_id    = int(request.form["cliente_id"])
        automovil_id  = int(request.form["automovil_id"])
    except (KeyError, ValueError):
        flash("Datos inválidos en el formulario.", "danger")
        return redirect(url_for("orders.list_orders"))

    orden = Orden(
        cliente_id   = cliente_id,
        fecha        = date.today(),
        numero       = nro_orden,
        usuario_id   = current_user.id,
        automovil_id = automovil_id,
        estado       = estado_text        # guardamos directamente el VARCHAR
    )
    db.session.add(orden)
    db.session.flush()

    # Servicios
    for sid, cant in zip(
        request.form.getlist("servicio_id[]"),
        request.form.getlist("servicio_cantidad[]")
    ):
        try:
            sid_int = int(sid)
            qty     = int(cant)
        except ValueError:
            continue
        if qty > 0:
            orden.agregar_servicio(sid_int, qty)

    # Productos
    for pid, cant in zip(
        request.form.getlist("producto_id[]"),
        request.form.getlist("producto_cantidad[]")
    ):
        try:
            pid_int = int(pid)
            qty     = int(cant)
        except ValueError:
            continue
        if qty > 0:
            orden.agregar_producto(pid_int, qty)

    db.session.commit()
    flash("Orden creada correctamente.", "success")
    return redirect(url_for("orders.list_orders"))
