
from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app, send_file
from flask_login   import login_user, login_required, logout_user, current_user
from flask_mail    import Message
from flask_sqlalchemy import SQLAlchemy
from itsdangerous  import SignatureExpired, BadSignature
from werkzeug.security import generate_password_hash
from app.extensions      import db, mail
from app.models.usuario  import User
from app.models.inventario import Inventario
from app.models import Servicio, rol, Producto, Categoria, usuario
from app.decorators import roles_requeridos
import io, csv
from config import Config
import app.extensions as ext
import qrcode
import io


main_bp = Blueprint('main', __name__)


@main_bp.route('/admin/panel')
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



@main_bp.route("/login", methods=["GET", "POST"])
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



@main_bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombres = request.form['nombres']
        apellidos = request.form['apellidos']
        email = request.form['email'].strip().lower()
        password = request.form['password']
        password2 = request.form['password2']

        if password != password2:
            flash("Las contraseñas no coinciden.", "danger")
            return redirect(url_for('main.register'))

        # Validar si el correo ya existe en usuarios
        if User.query.filter_by(email=email).first():
            flash("Ese correo ya está registrado como usuario.", "danger")
            return redirect(url_for('main.register'))

        # Validar si el correo ya existe en personas
        from app.models.persona import Persona  # <-- Asegúrate de importar Persona
        persona_existente = Persona.query.filter_by(correo=email).first()
        if persona_existente:
            flash("Ya existe una persona registrada con ese correo.", "danger")
            return redirect(url_for('main.register'))

        # Puedes pedir el documento en el form, aquí uso uno genérico
        nueva_persona = Persona(
            documento="00000000",
            nombres=nombres,
            apellidos=apellidos,
            correo=email,
            rol_id=1,
            activo=True
        )
        db.session.add(nueva_persona)
        db.session.commit()

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



@main_bp.route("/forgot", methods=["GET", "POST"])
def forgot():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        user = User.query.filter_by(email=email).first()
        if user:
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
            try:
                mail.send(msg)
            except Exception as e:
                print(f"[MAIL ERROR] {e}")  # En producción, usa logging
        flash("Si ese correo existe, recibirás un enlace para restablecer contraseña.", "info")
        return redirect(url_for("main.login"))

    return render_template("forgot.html")



@main_bp.route("/reset/<token>", methods=["GET", "POST"])
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
        print(f"[RESET] Intento de reset para correo inexistente: {email}")
        return redirect(url_for("main.register"))

    if request.method == "POST":
        pw1 = request.form.get("password")
        pw2 = request.form.get("password2")
        if not pw1 or not pw2 or pw1 != pw2:
            flash("Las contraseñas no coinciden o faltan datos.", "warning")
            return render_template("reset.html", token=token)
        try:
            user.set_password(pw1)
            db.session.commit()
        except Exception as e:
            print(f"[RESET ERROR] {e}")
            flash("Ocurrió un error actualizando la contraseña. Intenta nuevamente.", "danger")
            return render_template("reset.html", token=token)
        flash("Contraseña actualizada. Ahora puedes iniciar sesión.", "success")
        return redirect(url_for("main.login"))

    return render_template("reset.html", token=token)


@main_bp.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("main.login"))


@main_bp.route('/', methods=['GET'])
@login_required
def dashboard():
    # 1) Obtener la página actual desde la query string (por defecto es la 1)
    page = request.args.get('page', 1, type=int)

    # 2) Hacer la consulta paginada sobre el modelo Orden
    pagination = (
        Inventario.query
             .order_by(Inventario.id.desc())
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

