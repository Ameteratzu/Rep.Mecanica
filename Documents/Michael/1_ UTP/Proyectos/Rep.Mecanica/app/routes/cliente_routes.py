from flask import Blueprint, render_template, request, redirect, url_for, send_file
from flask_login import login_required
from app.models.cliente import Cliente
from app.models.ubigeo import Ubigeo
from app.extensions import db
import pandas as pd
import io

# Blueprint de cliente
cliente_bp = Blueprint(
    "cliente",
    __name__,
    url_prefix="/clientes",
    template_folder="templates/clients"
)

# Ruta para listar clientes con paginación
@cliente_bp.route("/", methods=["GET"])
@login_required
def list_cliente():
    page = request.args.get("page", 1, type=int)
    estado = request.args.get('estado', 'Todos')
    search = request.args.get('search', '')

    query = Cliente.query
    if estado != 'Todos':
        query = query.filter(Cliente.activo == (estado == 'Activo'))
    if search:
        query = query.filter(
            Cliente.nombres.contains(search) |
            Cliente.documento.contains(search) |
            Cliente.celular.contains(search)
        )

    pagination = query.order_by(Cliente.id.desc()).paginate(page=page, per_page=10, error_out=False)
    clientes = pagination.items
    ubigeos = Ubigeo.query.all()

    return render_template(
        "cliente_pag/cliente_list.html",
        clientes=clientes,
        ubigeos=ubigeos,
        pagination=pagination,
        estado=estado,
        search=search,
        active="cliente"
    )

# Ruta para crear un nuevo cliente
@cliente_bp.route("/nuevo", methods=["POST"])
@login_required
def nuevo_cliente():
    tipo_documento = request.form.get("tipo_documento")
    documento = request.form.get("documento")
    nombres = request.form.get("nombres")
    apellidos = request.form.get("apellidos")
    correo = request.form.get("correo")
    direccion = request.form.get("direccion")
    celular = request.form.get("celular")
    activo = request.form.get("activo") == "1"

    ubigeo_id_raw = request.form.get("ubigeo_id")
    if not ubigeo_id_raw or not ubigeo_id_raw.isdigit() or int(ubigeo_id_raw) == 0:
        return "Ubigeo inválido o no seleccionado", 400

    ubigeo_id = int(ubigeo_id_raw)
    ubigeo = Ubigeo.query.get(ubigeo_id)
    if not ubigeo:
        return "Ubigeo no encontrado", 400

    if not all([tipo_documento, documento, nombres, apellidos]):
        return "Faltan campos obligatorios", 400

    cliente = Cliente(
        tipo_documento=tipo_documento,
        documento=documento,
        nombres=nombres,
        apellidos=apellidos,
        correo=correo,
        ubigeo_id=ubigeo_id,
        direccion=direccion,
        celular=celular,
        activo=activo
    )
    db.session.add(cliente)
    db.session.commit()
    return redirect(url_for('cliente.list_cliente'))

# Ruta para editar un cliente
@cliente_bp.route("/editar/<int:cliente_id>", methods=["GET", "POST"])
@login_required
def editar_cliente(cliente_id):
    cliente = Cliente.query.get_or_404(cliente_id)

    if request.method == "POST":
        cliente.nombres = request.form["nombres"]
        cliente.apellidos = request.form["apellidos"]
        cliente.documento = request.form["documento"]
        cliente.celular = request.form["celular"]
        cliente.tipo_documento = request.form["tipo_documento"]
        cliente.activo = request.form.get("activo") == "1"

        db.session.commit()
        return redirect(url_for('cliente.list_cliente'))

    return render_template("cliente_pag/cliente_edit.html", cliente=cliente)

# Ruta para eliminar un cliente
@cliente_bp.route('/eliminar/<int:cliente_id>', methods=["POST"])
@login_required
def eliminar_cliente(cliente_id):
    cliente = Cliente.query.get_or_404(cliente_id)
    db.session.delete(cliente)
    db.session.commit()
    return redirect(url_for('cliente.list_cliente'))

# Ruta para exportar clientes a un archivo Excel
@cliente_bp.route('/export', methods=['GET'])
@login_required
def export_excel():
    clientes = Cliente.query.all()
    df = pd.DataFrame([{
        'ID': c.id,
        'Documento': c.documento,
        'Nombre': c.nombres,
        'Apellido': c.apellidos,
        'Celular': c.celular
    } for c in clientes])

    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Clientes')

    output.seek(0)
    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_name='clientes.xlsx',
        as_attachment=True
    )
