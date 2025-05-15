# app/blueprints/admin/roles.py

from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_required
from app.decorators import roles_requeridos
from app.models.rol import Rol
from app.extensions import db

roles_bp = Blueprint('admin_roles', __name__)

@roles_bp.route('/admin/roles')
@login_required
@roles_requeridos('administrador')
def lista_roles():
    roles = Rol.query.order_by(Rol.id).all()
    # return render_template('admin/roles/lista.html', roles=roles) # Solo si usas templates
    return {"roles": [dict(id=r.id, rol=r.rol, activo=r.activo) for r in roles]} # Respuesta API para pruebas

@roles_bp.route('/admin/roles/nuevo', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def nuevo_rol():
    nombre = request.form['nombre'].strip().lower()
    if Rol.query.filter_by(rol=nombre).first():
        flash('Ese rol ya existe.', 'warning')
        return redirect(url_for('admin_roles.lista_roles'))
    rol = Rol(rol=nombre, activo=True)
    db.session.add(rol)
    db.session.commit()
    flash('Rol creado correctamente.', 'success')
    return redirect(url_for('admin_roles.lista_roles'))

@roles_bp.route('/admin/roles/<int:id>/editar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def editar_rol(id):
    rol = Rol.query.get_or_404(id)
    rol.rol = request.form['nombre'].strip().lower()
    rol.activo = bool(int(request.form.get('activo', 1)))
    db.session.commit()
    flash('Rol actualizado.', 'success')
    return redirect(url_for('admin_roles.lista_roles'))

@roles_bp.route('/admin/roles/<int:id>/activar')
@login_required
@roles_requeridos('administrador')
def activar_rol(id):
    rol = Rol.query.get_or_404(id)
    rol.activo = True
    db.session.commit()
    flash('Rol activado.', 'success')
    return redirect(url_for('admin_roles.lista_roles'))

@roles_bp.route('/admin/roles/<int:id>/desactivar')
@login_required
@roles_requeridos('administrador')
def desactivar_rol(id):
    rol = Rol.query.get_or_404(id)
    rol.activo = False
    db.session.commit()
    flash('Rol desactivado.', 'warning')
    return redirect(url_for('admin_roles.lista_roles'))
