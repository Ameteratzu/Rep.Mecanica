# app/blueprints/main/routes.py

from flask import (
    Blueprint, render_template, redirect,
    url_for, request, flash, current_app
)
from flask_login   import login_user, login_required, logout_user, current_user
from flask_mail    import Message
from itsdangerous  import SignatureExpired, BadSignature

from app.extensions      import db, mail, ts
from app.models.usuario  import User
from app.models.cliente import Cliente 

main = Blueprint("main", __name__)


@main.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email    = request.form["email"].strip().lower()
        password = request.form["password"]
        user = User.query.filter_by(email=email, active=True).first()
        if user and user.check_password(password):
            login_user(user)
            return redirect(url_for("main.dashboard"))
        flash("Usuario o contraseña incorrectos", "danger")

    return render_template("login.html")


@main.route("/register", methods=["GET", "POST"])
def register():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email     = request.form["email"].strip().lower()
        password  = request.form["password"]
        password2 = request.form["password2"]
        if not email or not password:
            flash("Correo y contraseña son obligatorios", "warning")
            return redirect(url_for("main.register"))
        if password != password2:
            flash("Las contraseñas no coinciden", "warning")
            return redirect(url_for("main.register"))
        if User.query.filter_by(email=email).first():
            flash("Ya existe una cuenta con ese correo", "warning")
            return redirect(url_for("main.register"))

        new_user = User(email=email)
        new_user.set_password(password)
        db.session.add(new_user)
        db.session.commit()

        flash("Cuenta creada. Ya puedes iniciar sesión.", "success")
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
        email = ts.loads(token, salt=current_app.config["SECURITY_PASSWORD_SALT"], max_age=3600)
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


@main.route("/", methods=["GET"])
@login_required
def dashboard():
    # Paginar clientes
    page     = request.args.get("page", 1, type=int)
    per_page = 10
    pagination = Cliente.query \
        .order_by(Cliente.id.desc()) \
        .paginate(page=page, per_page=per_page, error_out=False)
    clients = pagination.items

    return render_template(
        "index.html",
        clients    = clients,
        pagination = pagination
    )

@main.route("/clientes/nuevo", methods=["POST"])
@login_required
def create_client():
    """
    Procesa el POST desde el modal de 'Agregar' en el dashboard.
    """
    documento = request.form.get("documento", "").strip()
    nombres   = request.form.get("nombres",   "").strip()
    apellidos = request.form.get("apellidos", "").strip()
    correo    = request.form.get("correo",    "").strip().lower()
    celular   = request.form.get("celular",   "").strip()

    # Validación mínima
    if not documento or not nombres or not apellidos or not correo:
        flash("Todos los campos son obligatorios.", "warning")
        return redirect(url_for("main.dashboard", page=request.args.get("page", 1)))

    # Crea y guarda el Cliente
    cliente = Cliente(
        documento=documento,
        nombres=nombres,
        apellidos=apellidos,
        correo=correo,
        ubigeo_id=1,     # Ajusta según tu lógica
        direccion="",
        celular=celular
    )
    db.session.add(cliente)
    db.session.commit()

    flash("Cliente agregado correctamente.", "success")
    return redirect(url_for("main.dashboard", page=request.args.get("page", 1)))
