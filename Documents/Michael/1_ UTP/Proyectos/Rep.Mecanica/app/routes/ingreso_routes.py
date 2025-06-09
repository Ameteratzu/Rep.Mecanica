from flask import Blueprint, render_template, request, redirect, url_for, flash, send_file
from flask_login import login_required
from app.extensions import db
from app.models.ingreso import Ingreso
from app.models.ingreso_producto import IngresoProducto
from app.models.proveedor import Proveedor
from app.models.producto import Producto
import pandas as pd
import io
from datetime import datetime

ingreso_bp = Blueprint("ingreso", __name__, url_prefix="/ingresos")

@ingreso_bp.route('/', methods=['GET'])
@login_required
def list_ingresos():
    search = request.args.get('search', '').strip()
    estado = request.args.get('estado', 'Activo')
    page = request.args.get('page', 1, type=int)

    query = Ingreso.query.join(Proveedor)

    if search:
        query = query.filter(Ingreso.referencia.like(f'%{search}%'))

    if estado == 'Activo':
        query = query.filter(Ingreso.activo == True)
    elif estado == 'Inactivo':
        query = query.filter(Ingreso.activo == False)
    
    query = query.order_by(Ingreso.id.desc())

    pagination = query.paginate(page=page, per_page=10)
    ingresos = pagination.items
    
    proveedores = Proveedor.query.filter_by(activo=True).all()
    productos = Producto.query.all()

    return render_template(
        "ingreso_pag/ingreso_list.html",
        ingresos=ingresos,
        pagination=pagination,
        search=search,
        estado=estado, 
        proveedores=proveedores,
        productos=productos
    )


@ingreso_bp.route("/nuevo", methods=["GET", "POST"])
@login_required
def nuevo_ingreso():
    if request.method == "POST":
        # Datos del ingreso
        referencia = request.form.get("referencia")
        guia = request.form.get("guia")
        concepto = request.form.get("concepto")
        fecha = request.form.get("fecha")  # Considera convertir a date si es necesario
        observacion = request.form.get("observacion")
        proveedor_id = request.form.get("proveedor_id")

        # Parsear productos enviados desde el formulario
        productos_form = {}
        for key in request.form:
            if key.startswith("productos["):
                import re
                m = re.match(r"productos\[(\d+)\]\[(\w+)\]", key)
                if m:
                    idx = int(m.group(1))
                    field = m.group(2)
                    productos_form.setdefault(idx, {})[field] = request.form.get(key)

        productos = []
        total = 0  # Inicializar total

        for idx in productos_form:
            p = productos_form[idx]
            if 'id' in p and 'cantidad' in p and 'costo' in p:
                try:
                    cantidad = int(p['cantidad'])
                    costo = float(p['costo'])
                    total += cantidad * costo  # Calcular total

                    ingreso_producto = IngresoProducto(
                        producto_id=int(p['id']),
                        cantidad=cantidad,
                        costo=costo,
                        total=cantidad * costo
                    )
                    productos.append(ingreso_producto)
                except Exception as e:
                    flash(f"Error al procesar producto: {p}. Detalle: {e}", "danger")
                    return redirect(url_for("ingreso.nuevo_ingreso"))

        # Crear el ingreso ahora que ya tienes el total calculado
        ingreso = Ingreso(
            referencia=referencia,
            guia=guia,
            concepto=concepto,
            fecha=fecha,
            observacion=observacion,
            proveedor_id=proveedor_id,
            total=total  # Total correcto
        )

        db.session.add(ingreso)
        db.session.flush()  # Para obtener ingreso.id antes del commit

        # Asignar ingreso_id a cada producto y agregarlos a la sesión
        for ip in productos:
            ip.ingreso_id = ingreso.id
            db.session.add(ip)

        # Commit final
        try:
            db.session.commit()
            flash("Ingreso registrado correctamente", "success")
            return redirect(url_for("ingreso.list_ingresos"))
        except Exception as e:
            db.session.rollback()
            flash(f"Error al guardar ingreso: {e}", "danger")
            return redirect(url_for("ingreso.list_ingresos"))

    # GET: mostrar formulario con proveedores y productos para seleccionar
    proveedores = Proveedor.query.all()
    productos = Producto.query.all()
    return redirect(url_for("ingreso.list_ingresos"))


@ingreso_bp.route('/editar/<int:ingreso_id>', methods=['GET', 'POST'])
@login_required
def editar_ingreso(ingreso_id):
    ingreso = Ingreso.query.get_or_404(ingreso_id)
    proveedores = Proveedor.query.all()
    productos = Producto.query.all()

    if request.method == 'POST':
        ingreso.referencia = request.form["referencia"]
        ingreso.guia = request.form["guia"]
        ingreso.concepto = request.form["concepto"]
        ingreso.fecha = datetime.strptime(request.form["fecha"], "%Y-%m-%d").date()
        ingreso.proveedor_id = request.form["proveedor_id"]
        ingreso.observacion = request.form.get("observacion", "")

        db.session.query(IngresoProducto).filter_by(ingresos_id=ingreso.id).delete()

        total_general = 0
        productos_ids = request.form.getlist("producto_id")
        cantidades = request.form.getlist("cantidad")
        costos = request.form.getlist("costo")

        for prod_id, cant, cost in zip(productos_ids, cantidades, costos):
            cantidad = int(cant)
            costo = float(cost)
            total = cantidad * costo
            ingreso_producto = IngresoProducto(
                ingresos_id=ingreso.id,
                producto_id=prod_id,
                cantidad=cantidad,
                costo=costo,
                total=total
            )
            total_general += total
            db.session.add(ingreso_producto)

        ingreso.total = total_general
        db.session.commit()
        return redirect(url_for('ingreso.list_ingresos'))

    return render_template("ingreso_pag/ingreso_edit.html", ingreso=ingreso, proveedores=proveedores, productos=productos)

@ingreso_bp.route('/eliminar/<int:ingreso_id>', methods=['POST'])
@login_required
def eliminar_ingreso(ingreso_id):
    ingreso = Ingreso.query.get_or_404(ingreso_id)
    db.session.delete(ingreso)
    db.session.commit()
    return redirect(url_for('ingreso.list_ingresos'))

@ingreso_bp.route('/exportar', methods=['GET'])
@login_required
def exportar_ingresos_excel():
    ingresos = Ingreso.query.order_by(Ingreso.id.desc()).all()
    data = []

    for ingreso in ingresos:
        data.append({
            "ID": ingreso.id,
            "Referencia": ingreso.referencia,
            "Guía": ingreso.guia,
            "Concepto": ingreso.concepto,
            "Fecha": ingreso.fecha.strftime("%Y-%m-%d"),
            "Proveedor": ingreso.proveedor.razon_social if ingreso.proveedor else '',
            "Total": float(ingreso.total),
            "Observación": ingreso.observacion or ''
        })

    df = pd.DataFrame(data)
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine="xlsxwriter") as writer:
        df.to_excel(writer, index=False, sheet_name="Ingresos")
    output.seek(0)

    return send_file(
        output,
        download_name="ingresos.xlsx",
        as_attachment=True,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
