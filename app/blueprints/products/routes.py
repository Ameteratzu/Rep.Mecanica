from flask import Blueprint, render_template, request, request, redirect, url_for, flash
from flask_login import login_required
from app.extensions import db
from app.models.producto import Producto
from flask import Blueprint, redirect, url_for, flash, send_file
from app.models.categoria import Categoria  # importa el modelo Categoria
from . import products
import io
import csv
import pandas as pd

products_bp = Blueprint("products", __name__, url_prefix="/productos")


from flask import render_template, request
from flask_login import login_required
from app.models.producto import Producto
from . import products

@products.route("/", methods=["GET"])
@login_required
def list_products():
    page = request.args.get("page", 1, type=int)
    pagination = Producto.query.order_by(Producto.id.desc()).paginate(page=page, per_page=10, error_out=False)
    categorias = Categoria.query.order_by(Categoria.categoria).all()
    return render_template(
        "products/list.html",
        productos=pagination.items,
        pagination=pagination,
        categorias=categorias
    )

@products.route('/<int:product_id>/editar', methods=['GET','POST'])
@login_required
def edit_product(product_id):
    producto = Producto.query.get_or_404(product_id)
    page      = request.args.get('page', 1, type=int)
    categorias = Categoria.query.order_by(Categoria.categoria).all()

    if request.method == 'POST':
        producto.codigo  = request.form['codigo'].strip()
        producto.nombre  = request.form['nombre'].strip()
        producto.marca   = request.form['marca'].strip()
        producto.precio  = float(request.form['precio'])
        producto.activo  = 'activo' in request.form
        try:
            db.session.commit()
            flash('Producto actualizado correctamente.', 'success')
        except Exception as e:
            db.session.rollback()
            flash(f'Error al actualizar: {e}', 'danger')
        return redirect(url_for('products.list_products', page=page))

    return render_template(
        'products/edit.html',
        producto   = producto,
        categorias = categorias,
        page        = page
    )

@products.route('/<int:product_id>/eliminar', methods=['POST'])
@login_required
def delete_product(product_id):
    """
    Elimina un producto y redirige al listado en la misma página.
    """
    producto = Producto.query.get_or_404(product_id)
    page = request.args.get('page', 1, type=int)
    try:
        db.session.delete(producto)
        db.session.commit()
        flash('Producto eliminado correctamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al eliminar el producto: {e}', 'danger')
    return redirect(url_for('products.list_products', page=page))

@products_bp.route('/exportar', methods=['GET'])
@login_required
def export_products_excel():
    productos = Producto.query.order_by(Producto.id).all()
    si = io.StringIO()
    writer = csv.writer(si)
    writer.writerow(['ID', 'Código', 'Nombre', 'Marca', 'Precio', 'Activo'])
    for p in productos:
        writer.writerow([p.id, p.codigo, p.nombre, p.marca, p.precio, 'Activo' if p.activo else 'Inactivo'])
    mem = io.BytesIO()
    mem.write(si.getvalue().encode('utf-8'))
    mem.seek(0)
    return send_file(
        mem,
        as_attachment=True,
        download_name='productos.csv',
        mimetype='text/csv'
    )
@products.route('/nuevo', methods=['POST'])
@login_required
def create_product():
    codigo       = request.form['codigo']
    categoria_id = request.form['categoria_id']
    nombre       = request.form['nombre']
    marca        = request.form.get('marca', '')
    precio       = request.form['precio']
    activo       = request.form['activo'] == '1'
    
    # Manejo de imagen
    imagen_file = request.files.get('imagen')
    filename = None
    if imagen_file and imagen_file.filename:
        filename = secure_filename(imagen_file.filename)
        upload_folder = os.path.join('app', 'static', 'img', 'productos')
        os.makedirs(upload_folder, exist_ok=True)
        path = os.path.join(upload_folder, filename)
        imagen_file.save(path)

    nuevo_producto = Producto(
        codigo=codigo,
        categoria_id=categoria_id,
        nombre=nombre,
        marca=marca,
        precio=precio,
        activo=activo,
        imagen=filename  # Solo si tu modelo tiene el campo imagen
    )
    db.session.add(nuevo_producto)
    db.session.commit()
    flash('Producto agregado correctamente', 'success')
    return redirect(url_for('products.list_products'))