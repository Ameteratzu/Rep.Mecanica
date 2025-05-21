from flask import Blueprint, render_template, request, redirect, url_for
from flask_login import login_required
from app.models.cliente import Cliente
from app.extensions import db
from app.models.ubigeo import Ubigeo

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
    ubigeos = Ubigeo.query.all()
    
    return render_template(
        "cliente/list.html",
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
    if request.method == "POST":
        # Obtener los datos del formulario
        tipo_documento = request.form.get("tipo_documento")  # usar paréntesis
        documento = request.form.get("documento")            # usar request.form.get
        nombres = request.form["nombres"]                     # está bien usar corchetes si seguro existe
        apellidos = request.form["apellidos"]
        correo = request.form["correo"]
            # con get y valor por defecto para evitar error
        direccion = request.form["direccion"]
        celular = request.form["celular"]
        activo = request.form.get("activo") == "1"            # get con paréntesis
        
        # Validar ubigeo_id        
       # Obtener y validar ubigeo_id correctamente
        ubigeo_id_raw = request.form.get("ubigeo_id", None)

        if not ubigeo_id_raw or not ubigeo_id_raw.isdigit() or int(ubigeo_id_raw) == 0:
            return "Ubigeo inválido o no seleccionado", 400

        ubigeo_id = int(ubigeo_id_raw)

        # Verificar que el ubigeo_id existe en la base de datos
        ubigeo = Ubigeo.query.get(ubigeo_id)
        if not ubigeo:
            return "Ubigeo no encontrado", 400


        # Validar campos obligatorios
        if not all([tipo_documento, documento, nombres, apellidos, ubigeo_id]):
            return "Faltan campos obligatorios", 400

        # Crear una nueva instancia de Cliente y agregarla a la base de datos
        cliente = Cliente(
            tipo_documento=tipo_documento,
            documento=documento,
            nombres=nombres,
            apellidos=apellidos,
            correo=correo,
            ubigeo_id=int(ubigeo_id),
            direccion=direccion,
            celular=celular,
            activo=activo
        )
        db.session.add(cliente)
        db.session.commit()

        # Redirigir al listado de clientes
        return redirect(url_for('cliente.list_cliente'))  # Redirige al listado de clientes

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
        cliente.activo = request.form.get("activo") == "1"  # Esto no funciona bien si recibes "0" o "1"

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
    