from flask import Blueprint, render_template, request, redirect, url_for, flash, send_file
from flask_login import login_required
from app.extensions import db
from app.models.ingreso import Ingreso
from app.models.ingreso_producto import IngresoProducto
from app.models.proveedor import Proveedor
from app.models.producto import Producto
from sqlalchemy import or_, cast
from sqlalchemy.types import String
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
        query = query.filter(
            or_(
                Ingreso.guia.like(f'%{search}%'),
                Ingreso.referencia.like(f'%{search}%'),
                cast(Ingreso.fecha, String).like(f'%{search}%'),
                Proveedor.razon_social.like(f'%{search}%')
            )
        )
    if estado == 'Activo':
        query = query.filter(Ingreso.activo == True)
    elif estado == 'Inactivo':
        query = query.filter(Ingreso.activo == False)
    
    query = query.order_by(Ingreso.id.desc())

    pagination = query.paginate(page=page, per_page=10)
    ingresos = pagination.items
    
    proveedores = Proveedor.query.filter_by(activo=True).all()
    productos = Producto.query.all()
    guia_tentativa = Ingreso.generar_codigo_guia()

    return render_template(
        "ingreso_pag/ingreso_list.html",
        ingresos=ingresos,
        pagination=pagination,
        search=search,
        estado=estado, 
        proveedores=proveedores,
        productos=productos,
        guia_tentativa=guia_tentativa
    )


@ingreso_bp.route("/nuevo", methods=["GET", "POST"])
@login_required
def nuevo_ingreso():
    if request.method == "POST":
        guia = Ingreso.generar_codigo_guia()
        # Datos del ingreso
        referencia = request.form.get("referencia")        
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
                    producto_id = int(p['id'])  # ✅ Definimos producto_id
                    cantidad = int(p['cantidad'])
                    costo = float(p['costo'])
                    total += cantidad * costo  # Calcular total

                    ingreso_producto = IngresoProducto(
                        producto_id=producto_id,
                        cantidad=cantidad,
                        costo=costo,
                        total=cantidad * costo
                    )
                    productos.append(ingreso_producto)

                    # ✅ Actualizamos el costo promedio y el inventario
                    producto = Producto.query.get(producto_id)
                    if producto:
                        producto.actualizar_costo_promedio(cantidad_nueva=cantidad, costo_nuevo=costo)

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
    else:    
    # GET: mostrar formulario con proveedores y productos para seleccionar
        guia_tentativa = Ingreso.generar_codigo_guia()
        
        proveedores = Proveedor.query.all()
        productos = Producto.query.all()
        return render_template("ingreso_pag/nuevo_ingreso.html", 
                                guia=guia_tentativa, 
                                proveedores=proveedores, 
                                productos=productos)

@ingreso_bp.route('/eliminado_logico/<int:ingreso_id>', methods=['POST'])
@login_required
def eliminado_logico(ingreso_id):
    ingreso = Ingreso.query.get_or_404(ingreso_id)

    if not ingreso.activo:
        flash("El ingreso ya se encuentra anulado, no se puede cambiar.", "warning")
        return redirect(url_for('ingreso.list_ingresos'))

    ingreso.activo = False  # Anular el ingreso (cambio lógico)

    try:
        db.session.commit()
        flash("El ingreso ha sido anulado correctamente.", "success")
    except Exception as e:
        db.session.rollback()
        flash(f"No se pudo anular el ingreso: {e}", "danger")

    return redirect(url_for('ingreso.list_ingresos'))


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
