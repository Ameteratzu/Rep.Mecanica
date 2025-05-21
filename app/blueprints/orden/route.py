from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models.orden import Orden
from app.extensions import db
from datetime import datetime

orden_bpp = Blueprint('orden', __name__)

@orden_bpp.route('/orden')
def list_orders():
    ordenes = Orden.query.all()
    return render_template('orden/orden.html', ordenes=ordenes)

@orden_bpp.route('/orden/create', methods=['POST'])
def create_order():
    try:
        cliente_id = request.form['cliente_id']
        numero = request.form['numero']
        usuario_id = request.form['usuario_id']
        automovil_id = request.form['automovil_id']
        descuento = request.form.get('descuento', 0.00)
        total = request.form['total']
        estado_orden_id = request.form['estado_orden_id']
        estado = request.form['estado']

        nueva_orden = Orden(
            cliente_id=cliente_id,
            fecha=datetime.utcnow(),
            numero=numero,
            usuario_id=usuario_id,
            automovil_id=automovil_id,
            descuento=descuento,
            total=total,
            estado_orden_id=estado_orden_id,
            activo=True,
            estado=estado
        )
        db.session.add(nueva_orden)
        db.session.commit()
        flash('Orden creada exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al crear la orden: {e}', 'danger')
    return redirect(url_for('orden.list_orders'))

@orden_bpp.route('/orden/update/<int:id>', methods=['POST'])
def update_order(id):
    orden = Orden.query.get_or_404(id)
    try:
        orden.cliente_id = request.form['cliente_id']
        orden.numero = request.form['numero']
        orden.usuario_id = request.form['usuario_id']
        orden.automovil_id = request.form['automovil_id']
        orden.descuento = request.form.get('descuento', 0.00)
        orden.total = request.form['total']
        orden.estado_orden_id = request.form['estado_orden_id']
        orden.estado = request.form['estado']
        db.session.commit()
        flash('Orden actualizada exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al actualizar la orden: {e}', 'danger')
    return redirect(url_for('orden.list_orders'))

@orden_bpp.route('/orden/delete/<int:id>', methods=['POST'])
def delete_order(id):
    orden = Orden.query.get_or_404(id)
    try:
        db.session.delete(orden)
        db.session.commit()
        flash('Orden eliminada exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al eliminar la orden: {e}', 'danger')
    return redirect(url_for('orden.list_orders'))