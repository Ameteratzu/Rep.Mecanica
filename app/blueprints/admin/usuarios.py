# app/blueprints/admin/usuarios.py

from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_required
from app.decorators import roles_requeridos
from app.models.usuario import User
from app.models.persona import Persona
from app.models.rol import Rol
from app.extensions import db
from werkzeug.security import generate_password_hash

usuarios_bp = Blueprint('admin_usuarios', __name__)

@usuarios_bp.route('/admin/usuarios')
@login_required
@roles_requeridos('administrador')
def lista_usuarios():
    usuarios = User.query.all()
    # return render_template('admin/usuarios/lista.html', usuarios=usuarios)
    return {"usuarios": [
        dict(id=u.id, email=u.email, persona=f"{u.persona.nombres} {u.persona.apellidos}", 
             rol=u.persona.rol.rol, active=u.active) for u in usuarios
    ]}

@usuarios_bp.route('/admin/usuarios/nuevo', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def nuevo_usuario():
    persona_id = int(request.form.get('persona_id', 0))
    email = request.form['email'].strip().lower()
    password = request.form['password']
    if User.query.filter_by(email=email).first():
        flash('Ya existe un usuario con ese correo.', 'warning')
        return redirect(url_for('admin_usuarios.lista_usuarios'))

    # Si no selecciona persona, crea nueva
    if persona_id == 0:
        documento = request.form['documento']
        nombres = request.form['nombres']
        apellidos = request.form['apellidos']
        correo_persona = request.form['correo_persona']
        rol_id = int(request.form['rol_id'])
        persona = Persona(
            documento=documento,
            nombres=nombres,
            apellidos=apellidos,
            correo=correo_persona,
            rol_id=rol_id,
            activo=True
        )
        db.session.add(persona)
        db.session.commit()
    else:
        persona = Persona.query.get_or_404(persona_id)

    usuario = User(
        email=email,
        password_hash=generate_password_hash(password),
        active=True,
        persona_id=persona.id
    )
    db.session.add(usuario)
    db.session.commit()
    flash('Usuario creado correctamente.', 'success')
    return redirect(url_for('admin_usuarios.lista_usuarios'))

@usuarios_bp.route('/admin/usuarios/<int:id>/editar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def editar_usuario(id):
    usuario = User.query.get_or_404(id)
    usuario.email = request.form['email'].strip().lower()
    usuario.active = 'active' in request.form
    persona_id = int(request.form['persona_id'])
    usuario.persona_id = persona_id
    db.session.commit()
    flash('Usuario actualizado correctamente.', 'success')
    return redirect(url_for('admin_usuarios.lista_usuarios'))

@usuarios_bp.route('/admin/usuarios/<int:id>/reset', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def resetear_contrasena_usuario(id):
    usuario = User.query.get_or_404(id)
    pw1 = request.form['password']
    pw2 = request.form['password2']
    if pw1 != pw2:
        flash('Las contraseñas no coinciden.', 'warning')
        return redirect(url_for('admin_usuarios.lista_usuarios'))
    usuario.set_password(pw1)
    db.session.commit()
    flash('Contraseña actualizada.', 'success')
    return redirect(url_for('admin_usuarios.lista_usuarios'))

@usuarios_bp.route('/admin/usuarios/<int:id>/eliminar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def eliminar_usuario(id):
    usuario = User.query.get_or_404(id)
    db.session.delete(usuario)
    db.session.commit()
    flash('Usuario eliminado.', 'success')
    return redirect(url_for('admin_usuarios.lista_usuarios'))
