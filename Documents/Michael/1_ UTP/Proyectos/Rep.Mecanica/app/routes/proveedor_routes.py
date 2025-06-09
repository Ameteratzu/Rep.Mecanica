from flask import Blueprint, render_template, request, redirect, url_for, flash, Response, send_file
from flask_login import login_required
from werkzeug.utils import secure_filename
from app.extensions import db
from app.models.proveedor import Proveedor
from app.models.ubigeo import Ubigeo  # importa el modelo Categoria
import io
import pandas as pd
import os 

proveedor_bp = Blueprint("proveedor", __name__, url_prefix="/proveedores")

@proveedor_bp.route('/', methods=['GET'])
@login_required
def list_proveedores():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', '').strip()
    estado = request.args.get('estado', '')
    query = Proveedor.query
    if search:
        query = query.filter(
            (Proveedor.ruc.like(f'%{search}%')) |
            (Proveedor.razon_social.like(f'%{search}%'))
        )
    if estado and estado != 'Todos':
        query = query.filter(Proveedor.activo == (estado == 'Activo'))

    pagination = query.order_by(Proveedor.id.desc()).paginate(page=page, per_page=10)
    proveedores = pagination.items
    
    ubigeos = Ubigeo.query.all()

    return render_template(
        'proveedor_pag/proveedor_list.html',
        proveedores=proveedores,
        pagination=pagination,
        search=search,
        estado=estado,ubigeos=ubigeos
    )
    
@proveedor_bp.route('/exportar', methods=['GET'])
@login_required
def export_proveedores_excel():  

    proveedores = Proveedor.query.order_by(Proveedor.id.desc()).all()

    # Crear DataFrame con los productos
    df = pd.DataFrame([{
        'ID': p.id,
        'RUC': p.ruc,
        'Razon_Social': p.razon_social,
        'Direccion': p.direccion,
        'telefono': p.telefono,
        'correo': p.correo,
        'contacto': p.contacto,
        'Estado': 'Activo' if p.activo else 'Inactivo'
    } for p in proveedores])

    # Guardar en un archivo Excel en memoria
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Proveedores')

    output.seek(0)

    # Enviar archivo al navegador
    return send_file(
        output,
        download_name="proveedores.xlsx",
        as_attachment=True,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )

@proveedor_bp.route("/nuevo", methods=["POST"])
@login_required
def nuevo_proveedor():
    ruc = request.form.get("ruc")
    razon_social = request.form.get("razon_social")
    direccion = request.form.get("direccion")
    telefono = request.form.get("telefono")
    correo = request.form.get("correo")
    contacto = request.form.get("contacto")    
    activo = request.form.get("activo") == "1"

    ubigeo_id_raw = request.form.get("ubigeo_id")
    if not ubigeo_id_raw or not ubigeo_id_raw.isdigit() or int(ubigeo_id_raw) == 0:
        return "Ubigeo inválido o no seleccionado", 400

    ubigeo_id = int(ubigeo_id_raw)
    ubigeo = Ubigeo.query.get(ubigeo_id)
    if not ubigeo:
        return "Ubigeo no encontrado", 400

    if not all([ruc, razon_social, telefono, contacto]):
        return "Faltan campos obligatorios", 400

    proveedor = Proveedor(
        ruc=ruc,
        razon_social=razon_social,
        ubigeo_id=ubigeo_id,
        direccion=direccion,
        telefono=telefono,
        correo=correo,
        contacto=contacto,
        activo=activo
    )
    db.session.add(proveedor)
    db.session.commit()
    return redirect(url_for('proveedor.list_proveedores'))

# Ruta para editar un cliente
@proveedor_bp.route("/editar/<int:proveedor_id>", methods=["GET", "POST"])
@login_required
def edit_proveedor(proveedor_id):
    proveedor = Proveedor.query.get_or_404(proveedor_id)
    ubigeos = Ubigeo.query.all()

    if request.method == "POST":
        proveedor.ruc = request.form["ruc"]
        proveedor.razon_social = request.form["razon_social"]
        proveedor.ubigeo_id = int(request.form["ubigeo_id"])
        proveedor.direccion = request.form["direccion"]
        proveedor.telefono = request.form["telefono"]
        proveedor.correo = request.form["correo"]
        proveedor.contacto = request.form["contacto"]
        proveedor.activo = request.form.get("activo") == "1"

        db.session.commit()
        return redirect(url_for('proveedor.list_proveedores'))

    return render_template("proveedor_pag/proveedor_edit.html", proveedor=proveedor, ubigeos=ubigeos)


@proveedor_bp.route("/cambiar_estado/<int:proveedor_id>", methods=["POST"])
@login_required
def cambiar_estado_proveedor(proveedor_id):
    proveedor = Proveedor.query.get_or_404(proveedor_id)
    proveedor.activo = not proveedor.activo
    db.session.commit()
    return redirect(url_for('proveedor.list_proveedores'))


# Ruta para eliminar un cliente
@proveedor_bp.route('/eliminar/<int:proveedor_id>', methods=["POST"])
@login_required
def eliminar_proveedor(proveedor_id):
    proveedor = Proveedor.query.get_or_404(proveedor_id)
    db.session.delete(proveedor)
    db.session.commit()
    return redirect(url_for('proveedor.list_proveedores'))
