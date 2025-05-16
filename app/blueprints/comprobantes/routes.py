from flask import Blueprint, render_template, request, send_file, flash, redirect, url_for
from flask_login import login_required
from app.models.comprobante import Comprobante, ComprobanteDetalle
from app.models.cliente import Cliente
from datetime import datetime
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
    return render_template(
        "comprobantes/list.html",
        comprobantes=comprobantes,
        search=search,
        active="comprobantes",
        hoy=datetime.now().strftime('%Y-%m-%d')  # <--- Esta línea es la clave
    )

@comprobantes_bp.route("/exportar", methods=["GET"])
@login_required
def exportar_comprobantes_excel():
    comprobantes = Comprobante.query.order_by(Comprobante.id).all()

    si = io.StringIO()
    writer = csv.writer(si)
    writer.writerow([
        'ID', 'Serie', 'Número', 'Fecha Emisión', 'Cliente',
        'Orden', 'Subtotal', 'IGV', 'Total', 'Forma de pago'
    ])
    for c in comprobantes:
        cliente = f"{c.cliente.nombres} {c.cliente.apellidos}" if c.cliente else "-"
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
            c.forma_pago or ''
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
        # Crea el cliente con los datos del formulario
        nombres = request.form.get("nombres")
        apellidos = request.form.get("apellidos")
        tipo_documento = request.form.get("tipo_documento")
        documento = request.form.get("documento")
        celular = request.form.get("celular")
        correo = request.form.get("correo")
        direccion = request.form.get("direccion")
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

    forma_pago = request.form.get("forma_pago")
    total = float(request.form.get("total") or 0)
    observaciones = request.form.get("observaciones") or ""
    subtotal = round(total / 1.18, 2)
    igv = round(total - subtotal, 2)
    ultimo = Comprobante.query.order_by(Comprobante.numero.desc()).first()
    numero = (ultimo.numero + 1) if ultimo else 1

    boleta = Comprobante(
        serie="B001",
        numero=numero,
        fecha_emision=datetime.utcnow(),
        cliente_id=int(cliente_id),
        subtotal=subtotal,
        igv=igv,
        total=total,
        forma_pago=forma_pago,
        observaciones=observaciones
    )
    db.session.add(boleta)
    db.session.commit()
    flash("Boleta registrada correctamente", "success")
    return redirect(url_for("comprobantes.list_comprobantes"))
