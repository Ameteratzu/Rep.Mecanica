from flask import (
    Blueprint, render_template, request,
    redirect, url_for, flash
)
from flask_login import login_required
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
    """
    Lista todas las órdenes, paginadas.
    """
    page     = request.args.get("page", 1, type=int)
    per_page = 10
    pagination = (
        Orden.query
             .order_by(Orden.id.desc())
             .paginate(page=page, per_page=per_page, error_out=False)
    )
    return render_template(
        "orders/list.html",
        orders     = pagination.items,
        pagination = pagination
    )


@orders_bp.route("/nueva", methods=["GET", "POST"])
@login_required
def create_order():
    """
    Muestra el formulario de creación (GET) y procesa la creación (POST).
    """
    estados   = EstadoOrden.query.filter_by(activo=True).all()
    productos = Producto.query.filter_by(activo=True).all()
    servicios = Servicio.query.filter_by(activo=True).all()

    if request.method == "POST":
        # Recoge datos principales
        estado_id    = request.form.get("estado_orden")
        nro_orden    = request.form.get("nro_orden")
        cliente_id   = request.form.get("cliente_id")
        automovil_id = request.form.get("automovil_id")

        # Crea la orden
        orden = Orden(
            estado_orden_id = estado_id,
            numero          = nro_orden,
            cliente_id      = cliente_id,
            automovil_id    = automovil_id
        )
        db.session.add(orden)
        db.session.flush()  # Para usar orden.id si es necesario

        # Añade servicios
        for sid, cant in zip(
            request.form.getlist("servicio_id[]"),
            request.form.getlist("servicio_cantidad[]")
        ):
            if sid and int(cant) > 0:
                orden.agregar_servicio(sid, int(cant))

        # Añade productos
        for pid, cant in zip(
            request.form.getlist("producto_id[]"),
            request.form.getlist("producto_cantidad[]")
        ):
            if pid and int(cant) > 0:
                orden.agregar_producto(pid, int(cant))

        db.session.commit()
        flash("Orden creada correctamente.", "success")
        return redirect(url_for("orders.list_orders"))

    # GET: muestra el formulario vacío
    return render_template(
        "orders/form.html",
        estados   = estados,
        productos = productos,
        servicios = servicios
    )
