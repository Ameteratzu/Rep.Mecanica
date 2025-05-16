from flask import Blueprint, render_template, request, send_file, flash, redirect, url_for
from flask_login import login_required
from app.models.comprobante import Comprobante, ComprobanteDetalle
from app.models.cliente import Cliente
from app.models.producto import Producto
from app.models.servicio import Servicio
from datetime import datetime, date
from app.extensions import db

import io
import csv
import qrcode

comprobantes_bp = Blueprint("comprobantes", __name__, url_prefix="/comprobantes")

@comprobantes_bp.route("/", methods=["GET"])
@login_required
def list_comprobantes():
    search = request.args.get('search', '').strip()
    query = Comprobante.query
    if search:
        query = query.join(Cliente).filter(
            (Comprobante.serie.ilike(f"%{search}%")) |
            (Comprobante.numero.ilike(f"%{search}%")) |
            (Cliente.nombres.ilike(f"%{search}%")) |
            (Cliente.apellidos.ilike(f"%{search}%")) |
            (Comprobante.total.ilike(f"%{search}%"))
        )
    comprobantes = query.order_by(Comprobante.id.desc()).all()
    clientes = Cliente.query.order_by(Cliente.nombres).all()
    productos = Producto.query.filter_by(activo=1).all()
    servicios = Servicio.query.filter_by(activo=1).all()
    hoy = date.today().strftime("%Y-%m-%d")
    return render_template(
        "comprobantes/list.html",
        comprobantes=comprobantes,
        clientes=clientes,
        productos=productos,
        servicios=servicios,
        hoy=hoy,
        search=search,
        active="comprobantes"
    )

@comprobantes_bp.route("/exportar", methods=["GET"])
@login_required
def exportar_comprobantes_excel():
    comprobantes = Comprobante.query.order_by(Comprobante.id).all()

    si = io.StringIO()
    writer = csv.writer(si)
    writer.writerow([
        'ID', 'Serie', 'Número', 'Fecha Emisión', 'Cliente',
        'Orden', 'Subtotal', 'IGV', 'Total', 'Forma de pago', 'Detalle'
    ])
    for c in comprobantes:
        cliente = f"{c.cliente.nombres} {c.cliente.apellidos}" if c.cliente else "-"
        # Exporta detalles (concatena todos en una sola celda)
        detalles = "; ".join([
            f"{d.descripcion} (x{d.cantidad} @ {d.precio_unitario})"
            for d in c.detalle
        ])
        writer.writerow([
            c.id,
            c.serie,
            c.numero,
            c.fecha_emision.strftime("%d/%m/%Y %H:%M") if c.fecha_emision else "",
            cliente,
            c.orden_id or '',
            "%.2f" % c.subtotal if hasattr(c, 'subtotal') else '',
            "%.2f" % c.igv if hasattr(c, 'igv') else '',
            "%.2f" % c.total if hasattr(c, 'total') else '',
            c.forma_pago or '',
            detalles
        ])

    mem = io.BytesIO()
    mem.write(si.getvalue().encode('utf-8'))
    mem.seek(0)

    return send_file(
        mem,
        as_attachment=True,
        download_name='comprobantes.csv',
        mimetype='text/csv'
    )

@comprobantes_bp.route('/imprimir/<int:comprobante_id>')
@login_required
def imprimir_comprobante(comprobante_id):
    comprobante = Comprobante.query.get_or_404(comprobante_id)
    return render_template(
        "comprobantes/imprimir.html",
        comprobante=comprobante
    )

@comprobantes_bp.route('/qr/<int:comprobante_id>')
@login_required
def qr_comprobante(comprobante_id):
    comprobante = Comprobante.query.get_or_404(comprobante_id)
    qr_data = f"RUC:20100100100|Serie:{comprobante.serie}|Nro:{comprobante.numero}|Total:{comprobante.total}|Fecha:{comprobante.fecha_emision.strftime('%d/%m/%Y')}"
    img = qrcode.make(qr_data)
    buf = io.BytesIO()
    img.save(buf, format='PNG')
    buf.seek(0)
    return send_file(buf, mimetype='image/png')

@comprobantes_bp.route("/nueva", methods=["POST"])
@login_required
def nueva_boleta():
    cliente_id = request.form.get("cliente_id")
    # Si no hay cliente_id, se creará uno nuevo usando los datos del formulario
    if not cliente_id or not cliente_id.isdigit():
        nombres = request.form.get("nuevo_nombres")
        apellidos = request.form.get("nuevo_apellidos")
        tipo_documento = request.form.get("nuevo_tipo_documento")
        documento = request.form.get("nuevo_documento")
        celular = request.form.get("nuevo_celular")
        correo = request.form.get("nuevo_correo")
        direccion = request.form.get("nuevo_direccion")
        if not (nombres and apellidos and tipo_documento and documento):
            flash("Faltan datos del nuevo cliente.", "danger")
            return redirect(request.referrer or url_for('comprobantes.list_comprobantes'))
        nuevo_cliente = Cliente(
            nombres=nombres,
            apellidos=apellidos,
            tipo_documento=tipo_documento,
            documento=documento,
            celular=celular,
            correo=correo,
            direccion=direccion,
            activo=True
        )
        db.session.add(nuevo_cliente)
        db.session.commit()
        cliente_id = nuevo_cliente.id

    # DETALLES DE PRODUCTO/SERVICIO
    descripciones = request.form.getlist("descripcion[]")
    cantidades = request.form.getlist("cantidad[]")
    precios = request.form.getlist("precio_unitario[]")
    productos_id = request.form.getlist("producto_id[]")  # Si envías el id del producto/servicio
    servicios_id = request.form.getlist("servicio_id[]")  # Si usas id de servicio

    # Calcular total general correctamente
    total = 0
    detalles = []
    for i, (desc, cant, precio) in enumerate(zip(descripciones, cantidades, precios)):
        try:
            cantidad = int(cant)
            precio_unit = float(precio)
        except (ValueError, TypeError):
            continue
        total_fila = cantidad * precio_unit
        # Identifica si es producto o servicio
        prod_id = productos_id[i] if i < len(productos_id) else None
        serv_id = servicios_id[i] if i < len(servicios_id) else None
        detalles.append({
            'descripcion': desc,
            'cantidad': cantidad,
            'precio_unitario': precio_unit,
            'total': total_fila,
            'producto_id': int(prod_id) if prod_id and prod_id.isdigit() else None,
            'servicio_id': int(serv_id) if serv_id and serv_id.isdigit() else None,
        })
        total += total_fila

    subtotal = round(total / 1.18, 2)
    igv = round(total - subtotal, 2)
    forma_pago = request.form.get("forma_pago")
    observaciones = request.form.get("observaciones") or ""
    fecha_emision = request.form.get("fecha_emision")
    if fecha_emision:
        try:
            fecha_emision = datetime.strptime(fecha_emision, "%Y-%m-%d")
        except Exception:
            fecha_emision = datetime.utcnow()
    else:
        fecha_emision = datetime.utcnow()

    ultimo = Comprobante.query.order_by(Comprobante.numero.desc()).first()
    numero = (ultimo.numero + 1) if ultimo else 1

    boleta = Comprobante(
        serie="B001",
        numero=numero,
        fecha_emision=fecha_emision,
        cliente_id=int(cliente_id),
        subtotal=subtotal,
        igv=igv,
        total=total,
        forma_pago=forma_pago,
        observaciones=observaciones
    )
    db.session.add(boleta)
    db.session.flush()  # Para obtener el id de boleta antes de commit

    # Guardar detalles: asocia producto_id o servicio_id si aplica
    for d in detalles:
        det = ComprobanteDetalle(
            comprobante_id=boleta.id,
            producto_id=d.get('producto_id'),
            descripcion=d['descripcion'],
            cantidad=d['cantidad'],
            precio_unitario=d['precio_unitario'],
            total=d['total']
            # Si tienes servicio_id, agrégalo aquí en tu modelo ComprobanteDetalle
        )
        db.session.add(det)
    db.session.commit()
    flash("Boleta registrada correctamente", "success")
    return redirect(url_for("comprobantes.list_comprobantes"))