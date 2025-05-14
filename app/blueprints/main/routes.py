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

main = Blueprint("main", __name__)


@main.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("main.index"))

    if request.method == "POST":
        email    = request.form["email"].strip().lower()
        password = request.form["password"]
        user = User.query.filter_by(email=email, active=True).first()
        if user and user.check_password(password):
            login_user(user)
            return redirect(url_for("main.index"))
        flash("Usuario o contraseña incorrectos", "danger")

    return render_template("login.html")


@main.route("/register", methods=["GET", "POST"])
def register():
    if current_user.is_authenticated:
        return redirect(url_for("main.index"))

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
        return redirect(url_for("main.index"))

    if request.method == "POST":
        email = request.form["email"].strip().lower()
        token = ts.dumps(email, salt=current_app.config["SECURITY_PASSWORD_SALT"])
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
        return redirect(url_for("main.index"))

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


@main.route("/")
@login_required
def index():
    return render_template("index.html")
