# app/blueprints/main/routes.py

from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login import login_user, login_required, logout_user, current_user
from flask_mail import Message
from itsdangerous import SignatureExpired, BadSignature
from werkzeug.security import generate_password_hash
from app.extensions import db, mail
from app.models.usuario import User
from app.models.persona import Persona
from app.models.cliente import Cliente

main = Blueprint("main", __name__, template_folder="templates/main")

@main.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        password = request.form["password"]
        user = User.query.filter_by(email=email, active=True).first()
        if user and user.check_password(password):
            login_user(user)
            return redirect(url_for("main.dashboard"))
        flash("Usuario o contraseña incorrectos", "danger")

    return render_template("login.html")

@main.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombres = request.form['nombres'].strip()
        apellidos = request.form['apellidos'].strip()
        email = request.form['email'].strip().lower()
        password = request.form['password']
        password2 = request.form['password2']

        if password != password2:
            flash("Las contraseñas no coinciden.", "danger")
            return redirect(url_for('main.register'))

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

@main.route("/forgot", methods=["GET", "POST"])
def forgot():
    if current_user.is_authenticated:
        return redirect(url_for("main.dashboard"))

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        token = current_app.ts.dumps(email, salt=current_app.config["SECURITY_SALT"])
        reset_url = url_for("main.reset_with_token", token=token, _external=True)

        msg = Message(
            subject=current_app.config.get("MAIL_SUBJECT_PREFIX", "") + " Restablece tu contraseña",
            sender=current_app.config.get("MAIL_DEFAULT_SENDER"),
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
        email = current_app.ts.loads(token, salt=current_app.config["SECURITY_SALT"], max_age=3600)
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
    page     = request.args.get("page", 1, type=int)
    per_page = 10
    pagination = Cliente.query.order_by(Cliente.id.desc()).paginate(page=page, per_page=per_page, error_out=False)
    return render_template(
        "index.html",
        clients=pagination.items,
        pagination=pagination
    )

@main.route("/clientes/nuevo", methods=["POST"])
@login_required
def create_client():
    documento = request.form.get("documento", "").strip()
    nombres   = request.form.get("nombres",   "").strip()
    apellidos = request.form.get("apellidos", "").strip()
    correo    = request.form.get("correo",    "").strip().lower()
    celular   = request.form.get("celular",   "").strip()

    if not documento or not nombres or not apellidos or not correo:
        flash("Todos los campos son obligatorios.", "warning")
        return redirect(url_for("main.dashboard", page=request.args.get("page", 1)))

    cliente = Cliente(
        documento=documento,
        nombres=nombres,
        apellidos=apellidos,
        ubigeo_id=1,
        direccion="",
        celular=celular
    )
    db.session.add(cliente)
    db.session.commit()

    flash("Cliente agregado correctamente.", "success")
    return redirect(url_for("main.dashboard", page=request.args.get("page", 1)))
