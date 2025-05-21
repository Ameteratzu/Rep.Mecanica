
from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.automovil import Automovil
from app.extensions import db

automovil_bpp = Blueprint('automovil', __name__)

@automovil_bpp.route('/automovil')
def list_automovil():
    automoviles = Automovil.query.all()
    return render_template('automovil/automovil.html', automoviles=automoviles)

@automovil_bpp.route('/automovil/create', methods=['POST'])
def create_automovil():
    try:
        cliente_id = request.form['cliente_id']
        placa = request.form['placa']
        marca = request.form['marca']
        modelo = request.form['modelo']
        # año y activo pueden ser nulos
        anio = request.form.get('año') or None
        color = request.form['color']
        activo = request.form.get('activo')
        if activo == '' or activo is None:
            activo = None
        else:
            activo = bool(int(activo))

        nuevo_automovil = Automovil(
            cliente_id=cliente_id,
            placa=placa,
            marca=marca,
            modelo=modelo,
            año=anio,
            color=color,
            activo=activo
        )
        db.session.add(nuevo_automovil)
        db.session.commit()
        flash('Automóvil creado exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al crear el automóvil: {e}', 'danger')
    return redirect(url_for('automovil.list_automovil'))

@automovil_bpp.route('/automovil/update/<int:id>', methods=['POST'])
def update_automovil(id):
    automoviles = Automovil.query.get_or_404(id)
    try:
        Automovil.cliente_id = request.form['cliente_id']
        Automovil.placa = request.form['placa']
        Automovil.marca = request.form['marca']
        Automovil.modelo = request.form['modelo']
        Automovil.año = request.form.get('año') or None
        Automovil.color = request.form['color']
        activo = request.form.get('activo')
        if activo == '' or activo is None:
            Automovil.activo = None
        else:
            Automovil.activo = bool(int(activo))
        db.session.commit()
        flash('Automóvil actualizado exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al actualizar el automóvil: {e}', 'danger')
    return redirect(url_for('automovil.list_automovil'))

@automovil_bpp.route('/automovil/delete/<int:id>', methods=['POST'])
def delete_automovil(id):
    automoviles = Automovil.query.get_or_404(id)
    try:
        db.session.delete(Automovil)
        db.session.commit()
        flash('Automóvil eliminado exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al eliminar el automóvil: {e}', 'danger')
    return redirect(url_for('automovil.list_automoviles')
)
