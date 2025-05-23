# app/blueprints/main/routes.py

from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login   import login_user, login_required, logout_user, current_user
from flask_mail    import Message
from flask_sqlalchemy import SQLAlchemy
from itsdangerous  import SignatureExpired, BadSignature
from werkzeug.security import generate_password_hash
from app.extensions      import db, mail
from app.models.usuario  import User
from app.models.cliente import Cliente 
from app.models.cliente import Cliente
from app.models.ubigeo import Ubigeo
from app.models.orden import Orden
from app.models.comprobante import Comprobante
from app.models import db, Persona, User  
from app.models.rol import Rol
from app.models.servicio import Servicio
from app.models.producto import Producto
import io, csv
from app.decorators import roles_requeridos
from flask import send_file
from . import main
from config import Config
import app.extensions as ext
import qrcode
import io
from flask import send_file


admin_panel_bp = Blueprint('admin_panel', __name__)

@admin_panel_bp.route('/admin/panel')
@login_required
@roles_requeridos('administrador')
def admin_panel():
    total_usuarios = User.query.count()
    total_roles = Rol.query.count()
    total_productos = Producto.query.count()
    total_servicios = Servicio.query.count()
    ultimos_usuarios = User.query.order_by(User.id.desc()).limit(5).all()
    ultimos_productos = Producto.query.order_by(Producto.id.desc()).limit(5).all()

    # Mensaje de bienvenida en el panel
    flash("¡Has ingresado al Panel de Administración!", "info")

    return render_template(
        'admin/panel.html',
        total_usuarios=total_usuarios,
        total_roles=total_roles,
        total_productos=total_productos,
        total_servicios=total_servicios,
        ultimos_usuarios=ultimos_usuarios,
        ultimos_productos=ultimos_productos
    )



@main.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        # Redirección clara si ya está logueado
        flash("Ya has iniciado sesión.", "info")
        # Si es admin, manda directo al panel admin
        if current_user.persona.rol.rol == "administrador":
            return redirect(url_for("admin_panel.admin_panel"))
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email    = request.form["email"].strip().lower()
        password = request.form["password"]
        user = User.query.filter_by(email=email, active=True).first()

        # Mensaje si usuario no existe o está inactivo
        if not user:
            flash("Usuario no existe o está inactivo.", "danger")
            return render_template("login.html")

        # Mensaje si la persona está inactiva
        if not user.persona.activo:
            flash("Usuario deshabilitado, contacta al administrador.", "danger")
            return render_template("login.html")

        # Mensaje si la contraseña no coincide
        if not user.check_password(password):
            flash("Contraseña incorrecta.", "danger")
            return render_template("login.html")

        login_user(user)

        # Si es administrador, directo al panel admin
        if user.persona.rol.rol == "administrador":
            flash("Bienvenido, Administrador.", "success")
            return redirect(url_for("admin_panel.admin_panel"))

        # Si es otro rol, redirige a dashboard general
        flash("Inicio de sesión exitoso.", "success")
        return redirect(url_for("main.dashboard"))

    return render_template("login.html")



@main.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombres = request.form['nombres']
        apellidos = request.form['apellidos']
        email = request.form['email']
        password = request.form['password']
        password2 = request.form['password2']

        if password != password2:
            flash("Las contraseñas no coinciden.", "danger")
            return redirect(url_for('main.register'))

        # Crear Persona
        nueva_persona = Persona(
            documento="00000000",  # reemplaza o haz que lo ingresen en el form
            nombres=nombres,
            apellidos=apellidos,
            correo=email,
            rol_id=1,
            activo=True
        )
        db.session.add(nueva_persona)
        db.session.commit()

        # Crear Usuario
        nuevo_usuario = User(
            email=email,
            password_hash=generate_password_hash(password),
            active=True,
            persona_id=nueva_persona.id
        )
        db.session.add(nuevo_usuario)
        db.session.commit()

        flash("Cuenta creada correctamente", "success")
        return redirect(url_for("main.login"))

    return render_template("register.html")



@main.route("/forgot", methods=["GET", "POST"])
def forgot():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        token = current_app.ts.dumps(email, salt=current_app.config["SECURITY_PASSWORD_SALT"])
        reset_url = url_for("main.reset_with_token", token=token, _external=True)

        msg = Message(
            subject=current_app.config["MAIL_SUBJECT_PREFIX"]+" Restablece tu contraseña",
            sender=current_app.config["MAIL_DEFAULT_SENDER"],
            recipients=[email]
        )
        msg.body = (
            f"Hola,\n\nPulsa este enlace para restablecer tu contraseña:\n{reset_url}\n\n"
            "Si no lo solicitaste, ignora este correo."
        )
        mail.send(msg)

        flash("Si ese correo existe, recibirás un enlace para restablecer contraseña.", "info")
        return redirect(url_for("main.login"))

    return render_template("forgot.html")


@main.route("/reset/<token>", methods=["GET", "POST"])
def reset_with_token(token):
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    try:
        email = current_app.ts.loads(token, salt=current_app.config["SECURITY_PASSWORD_SALT"],max_age=3600)
    except (SignatureExpired, BadSignature):
        flash("El enlace no es válido o ha expirado.", "danger")
        return redirect(url_for("main.forgot"))

    user = User.query.filter_by(email=email).first()

    if not user:
        flash("No existe ningún usuario con ese correo.", "warning")
        return redirect(url_for("main.register"))

    if request.method == "POST":
        pw1 = request.form["password"]
        pw2 = request.form["password2"]
        if not pw1 or pw1 != pw2:
            flash("Las contraseñas no coinciden.", "warning")
            return render_template("reset.html", token=token)

        user.set_password(pw1)
        db.session.commit()
        flash("Contraseña actualizada. Ahora puedes iniciar sesión.", "success")
        return redirect(url_for("main.login"))

    return render_template("reset.html", token=token)


@main.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("main.login"))


@main.route('/', methods=['GET'])
@login_required
def dashboard():
    # 1) Obtener la página actual desde la query string (por defecto es la 1)
    page = request.args.get('page', 1, type=int)

    # 2) Hacer la consulta paginada sobre el modelo Orden
    pagination = (
        Orden.query
             .order_by(Orden.id.desc())
             .paginate(page=page, per_page=10, error_out=False)
    )
    reparaciones = pagination.items

    # 3) Renderizar pasando 'pagination' y la lista de 'reparaciones'
    return render_template(
        'index.html',
        reparaciones=reparaciones,
        pagination=pagination,
        active='dashboard'
    )



@main.route('/clientes', methods=['GET'])
@login_required
def lista_clientes():
    estado = request.args.get('estado', 'Todos')
    search = request.args.get('search', '').strip()
    page = request.args.get('page', 1, type=int)

    query = Cliente.query

    # Filtro por estado
    if estado == 'Activo':
        query = query.filter(Cliente.activo == True)
    elif estado == 'Inactivo':
        query = query.filter(Cliente.activo == False)

    # Filtro por búsqueda
    if search:
        search_filter = f"%{search}%"
        query = query.filter(
            (Cliente.nombres.ilike(search_filter)) |
            (Cliente.apellidos.ilike(search_filter)) |
            (Cliente.documento.ilike(search_filter)) |
            (Cliente.celular.ilike(search_filter)) |
            (Cliente.correo.ilike(search_filter))
        )

    pagination = query.order_by(Cliente.id.desc()).paginate(page=page, per_page=10, error_out=False)
    clientes = pagination.items
    ubigeos = Ubigeo.query.order_by(Ubigeo.departamento, Ubigeo.provincia, Ubigeo.distrito).all()

    return render_template(
        'cliente/list.html',
        clientes=clientes,
        pagination=pagination,
        estado=estado,
        search=search,
        ubigeos=ubigeos
    )




@main.route('/clientes/nuevo', methods=['POST'])
@login_required
def nuevo_cliente():
    try:
        c = Cliente(
            tipo_documento = request.form.get('tipoDocumento', '').strip(),
            documento      = request.form.get('documento', '').strip(),
            nombres        = request.form.get('nombres', '').strip(),
            apellidos      = request.form.get('apellidos', '').strip(),
            correo         = request.form.get('correo', '').strip(),
            celular        = request.form.get('celular', '').strip(),
            direccion      = request.form.get('direccion', '').strip(),
            ubigeo_id      = int(request.form.get('ubigeo', 0)),
            activo         = bool(int(request.form.get('activo', 1)))
        )
        db.session.add(c)
        db.session.commit()
        flash('Cliente registrado correctamente', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al registrar cliente: {e}', 'danger')

    return redirect(url_for('main.lista_clientes'))


@main.route('/clientes/exportar', methods=['GET'])
@login_required
def exportar_clientes_excel():
    clientes = Cliente.query.order_by(Cliente.id).all()

    si = io.StringIO()
    writer = csv.writer(si)
    writer.writerow([
        'ID', 'Documento', 'Nombres', 'Apellidos',
        'Correo', 'Ubigeo ID', 'Dirección',
        'Celular', 'Activo'
    ])
    for c in clientes:
        writer.writerow([
            c.id, c.documento, c.nombres, c.apellidos,
            c.correo, c.ubigeo_id, c.direccion or '',
            c.celular or '', 'Activo' if c.activo else 'Inactivo'
        ])

    mem = io.BytesIO()
    mem.write(si.getvalue().encode('utf-8'))
    mem.seek(0)

    return send_file(
        mem,
        as_attachment=True,
        download_name='clientes.csv',
        mimetype='text/csv'
    )
    

@main.route('/clientes/<int:cliente_id>/editar', methods=['GET', 'POST'])
@login_required
def editar_cliente(cliente_id):
    cliente = Cliente.query.get_or_404(cliente_id)

    if request.method == 'POST':
        cliente.documento  = request.form['documento'].strip()
        cliente.nombres    = request.form['nombres'].strip()
        cliente.apellidos  = request.form['apellidos'].strip()
        cliente.correo     = request.form['correo'].strip().lower()      # si tienes ese campo
        cliente.celular    = request.form.get('celular', '').strip()
        cliente.activo     = 'activo' in request.form

        try:
            db.session.commit()
            flash('Cliente actualizado correctamente.', 'success')
        except Exception as e:
            db.session.rollback()
            flash(f'Error al actualizar: {e}', 'danger')

        return redirect(url_for('main.lista_clientes'))
    return render_template('editarCliente.html', cliente=cliente)


@main.route('/clientes/<int:cliente_id>/eliminar', methods=['POST'])
@login_required
def eliminar_cliente(cliente_id):
    cliente = Cliente.query.get_or_404(cliente_id)
    try:
        db.session.delete(cliente)
        db.session.commit()
        flash('Cliente eliminado correctamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al eliminar el cliente: {e}', 'danger')
    return redirect(url_for('main.lista_clientes'))


@main.route('/clientes/nuevo_desde_comprobante', methods=['POST'])
@login_required
def nuevo_cliente_desde_comprobante():
    # Procesa el formulario y agrega cliente a la BD
    c = Cliente(
        nombres=request.form['nombres'],
        apellidos=request.form['apellidos'],
        documento=request.form['documento'],
        # agrega los demás campos necesarios
        activo=True
    )
    db.session.add(c)
    db.session.commit()
    flash('Cliente registrado correctamente', 'success')
    # Redirige de vuelta a comprobantes (idealmente podrías regresar con JS y refrescar solo el select)
    return redirect(url_for('comprobantes.list_comprobantes'))
