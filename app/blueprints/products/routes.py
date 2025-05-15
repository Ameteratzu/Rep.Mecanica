from flask import request, redirect, url_for, flash
from flask_login import login_required
from app.extensions import db
from app.models.producto import Producto
from flask import Blueprint, redirect, url_for, flash
from app.models.categoria import Categoria  # importa el modelo Categoria
from . import products

products_bp = Blueprint("products", __name__, url_prefix="/productos")

from flask import render_template, request
from flask_login import login_required
from app.models.producto import Producto
from . import products

@products.route('/', methods=['GET'])
@login_required
def list_products():
    page     = request.args.get('page', 1, type=int)
    per_page = 10

    pagination = (
        Producto.query
                .order_by(Producto.id.desc())
                .paginate(page=page, per_page=per_page, error_out=False)
    )

    return render_template(
        'products/list.html',
        productos  = pagination.items,
        pagination = pagination
    )

@products.route('/crear', methods=['POST'])
@login_required
def create_product():
    """
    Procesa el formulario de creación de un nuevo producto (desde el modal).
    """
    codigo      = request.form['codigo'].strip()
    nombre      = request.form['nombre'].strip()
    marca       = request.form['marca'].strip()
    precio      = float(request.form['precio'])
    categoria_id= int(request.form['categoria_id'])
    activo      = 'activo' in request.form

    p = Producto(
        codigo=codigo,
        nombre=nombre,
        marca=marca,
        precio=precio,
        categoria_id=categoria_id,
        activo=activo
    )
    try:
        db.session.add(p)
        db.session.commit()
        flash('Producto registrado correctamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al registrar producto: {e}', 'danger')

    # redirige al listado en la misma página de paginación
    page = request.args.get('page', 1, type=int)
    return redirect(url_for('products.list_products', page=page))


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
