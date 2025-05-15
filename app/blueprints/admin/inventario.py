from flask import Blueprint, request, redirect, url_for, flash
from flask_login import login_required
from app.decorators import roles_requeridos
from app.models.producto import Producto
from app.models.categoria import Categoria
from app.extensions import db

inventario_bp = Blueprint('admin_inventario', __name__)

@inventario_bp.route('/admin/inventario')
@login_required
@roles_requeridos('administrador')
def lista_inventario():
    productos = Producto.query.all()
    # return render_template('admin/inventario/lista.html', productos=productos)
    return {"productos": [
        dict(id=p.id, nombre=p.nombre, marca=p.marca, categoria=p.categoria.categoria, precio=float(p.precio), activo=p.activo)
        for p in productos
    ]}

@inventario_bp.route('/admin/inventario/nuevo', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def nuevo_producto():
    nombre = request.form['nombre']
    marca = request.form['marca']
    categoria_id = int(request.form['categoria_id'])
    precio = float(request.form['precio'])
    producto = Producto(
        nombre=nombre, marca=marca, categoria_id=categoria_id, precio=precio, activo=True
    )
    db.session.add(producto)
    db.session.commit()
    flash('Producto creado correctamente.', 'success')
    return redirect(url_for('admin_inventario.lista_inventario'))

@inventario_bp.route('/admin/inventario/<int:id>/editar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def editar_producto(id):
    producto = Producto.query.get_or_404(id)
    producto.nombre = request.form['nombre']
    producto.marca = request.form['marca']
    producto.categoria_id = int(request.form['categoria_id'])
    producto.precio = float(request.form['precio'])
    producto.activo = 'activo' in request.form
    db.session.commit()
    flash('Producto actualizado.', 'success')
    return redirect(url_for('admin_inventario.lista_inventario'))

@inventario_bp.route('/admin/inventario/<int:id>/eliminar', methods=['POST'])
@login_required
@roles_requeridos('administrador')
def eliminar_producto(id):
    producto = Producto.query.get_or_404(id)
    db.session.delete(producto)
    db.session.commit()
    flash('Producto eliminado.', 'success')
    return redirect(url_for('admin_inventario.lista_inventario'))
