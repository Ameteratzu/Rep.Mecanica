from flask import Blueprint, render_template, request, redirect, url_for
from flask_login import login_required
from app.models.cliente import Cliente
from app.extensions import db

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
    # Obtenemos los parámetros de paginación
    page = request.args.get("page", 1, type=int)  # Página por defecto es la 1
    estado = request.args.get('estado', 'Todos')  # Obtener el estado (Activo, Inactivo, Todos)
    search = request.args.get('search', '')  # Obtener el término de búsqueda

    # Filtrar por estado y búsqueda
    query = Cliente.query
    if estado != 'Todos':
        query = query.filter(Cliente.activo == (estado == 'Activo'))
    if search:
        query = query.filter(Cliente.nombres.contains(search) | Cliente.documento.contains(search) | Cliente.celular.contains(search))

    # Paginación básica
    pagination = query.order_by(Cliente.id.desc()).paginate(page=page, per_page=10, error_out=False)
    clientes = pagination.items  # Obtén los clientes para la página actual

    return render_template(
        "cliente/list.html",
        clientes=clientes,
        pagination=pagination,
        estado=estado,
        search=search,
        active="cliente"
    )

# Ruta para crear un nuevo cliente
@cliente_bp.route("/nuevo", methods=["GET", "POST"])
@login_required
def nuevo_cliente():
    if request.method == "POST":
        # Obtener los datos del formulario
        nombres = request.form["nombres"]
        apellidos = request.form["apellidos"]
        documento = request.form["documento"]
        celular = request.form["celular"]
        activo = bool(request.form["activo"])  # Convertir a booleano
        ubigeo_id = request.form["ubigeo"]  # Obtener el id del ubigeo

        # Crear una nueva instancia de Cliente y agregarla a la base de datos
        cliente = Cliente(nombres=nombres, apellidos=apellidos, documento=documento, celular=celular, activo=activo, ubigeo_id=ubigeo_id)
        db.session.add(cliente)
        db.session.commit()

        # Redirigir al listado de clientes
        return redirect(url_for('cliente.list_cliente'))  # Redirige al listado de clientes

    # Si es GET, obtenemos todos los ubigeos
    ubigeos = Ubigeo.query.all()  # Obtén todos los ubigeos disponibles en la base de datos
    return render_template("cliente/from.html", ubigeos=ubigeos)  # Pasamos los ubigeos a la plantilla
# Ruta para editar un cliente
@cliente_bp.route("/editar/<int:cliente_id>", methods=["GET", "POST"])
@login_required
def editar_cliente(cliente_id):
    cliente = Cliente.query.get_or_404(cliente_id)  # Obtener el cliente por ID

    if request.method == "POST":
        # Obtener datos del formulario y actualizar el cliente
        cliente.nombres = request.form["nombres"]
        cliente.apellidos = request.form["apellidos"]
        cliente.documento = request.form["documento"]
        cliente.celular = request.form["celular"]
        cliente.activo = bool(request.form["activo"])  # Convertir a booleano

        db.session.commit()  # Guardar cambios en la base de datos

        return redirect(url_for('cliente.list_cliente'))  # Redirigir al listado de clientes

    return render_template("cliente/editar_cliente.html", cliente=cliente)

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
    import pandas as pd
    import io
    from flask import send_file

    # Obtener los clientes
    clientes = Cliente.query.all()

    # Crear el DataFrame
    df = pd.DataFrame([{
        'ID': c.id,
        'Documento': c.documento,
        'Nombre': c.nombres,
        'Apellido': c.apellidos,
        'Celular': c.celular
    } for c in clientes])

    # Guardar el archivo en memoria
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Clientes')

    output.seek(0)

    # Este return es fundamental
    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_name='clientes.xlsx',
        as_attachment=True
    )
