from flask import Blueprint, request, redirect, url_for, flash
from flask_login import login_required
from app.decorators import roles_requeridos
from app.models.servicio import Servicio
from app.extensions import db

servicios_bp = Blueprint('admin_servicios', __name__)

@servicios_bp.route('/admin/servicios')
@login_required
@roles_requeridos('administrador')
def lista_servicios():
    servicios = Servicio.query.all()
    # return render_template('admin/servicios/lista.html', servicios=servicios)
    return {"servicios": [
        dict(id=s.id, nombre=s.nombre, descripcion=s.descripcion, precio=float(s.precio), descuento=float(s.descuento), activo=s.activo)
        for s in servicios
    ]}

@servicios_bp.route('/admin/servicios/nuevo', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def nuevo_servicio():
    nombre = request.form['nombre']
    descripcion = request.form['descripcion']
    precio = float(request.form['precio'])
    descuento = float(request.form['descuento'])
    servicio = Servicio(
        nombre=nombre, descripcion=descripcion, precio=precio, descuento=descuento, activo=True
    )
    db.session.add(servicio)
    db.session.commit()
    flash('Servicio creado correctamente.', 'success')
    return redirect(url_for('admin_servicios.lista_servicios'))

@servicios_bp.route('/admin/servicios/<int:id>/editar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def editar_servicio(id):
    servicio = Servicio.query.get_or_404(id)
    servicio.nombre = request.form['nombre']
    servicio.descripcion = request.form['descripcion']
    servicio.precio = float(request.form['precio'])
    servicio.descuento = float(request.form['descuento'])
    servicio.activo = 'activo' in request.form
    db.session.commit()
    flash('Servicio actualizado.', 'success')
    return redirect(url_for('admin_servicios.lista_servicios'))

@servicios_bp.route('/admin/servicios/<int:id>/eliminar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def eliminar_servicio(id):
    servicio = Servicio.query.get_or_404(id)
    db.session.delete(servicio)
    db.session.commit()
    flash('Servicio eliminado.', 'success')
    return redirect(url_for('admin_servicios.lista_servicios'))
