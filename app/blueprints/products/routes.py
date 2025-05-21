from flask import Blueprint, render_template, request, request, redirect, url_for, flash, Response
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

@products.route('/', methods=['GET'])
@login_required
def list_products():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', '').strip()
    estado = request.args.get('estado', '')
    query = Producto.query
    if search:
        query = query.filter(
            (Producto.codigo.like(f'%{search}%')) |
            (Producto.nombre.like(f'%{search}%')) |
            (Producto.marca.like(f'%{search}%'))
        )
    if estado and estado != 'Todos':
        query = query.filter(Producto.activo == (estado == 'Activo'))

    pagination = query.order_by(Producto.id.desc()).paginate(page=page, per_page=10)
    productos = pagination.items
    
    categorias = Categoria.query.all()

    return render_template(
        'products/list.html',
        productos=productos,
        pagination=pagination,
        search=search,
        estado=estado,categorias=categorias
    )

@products.route('/exportar', methods=['GET'])
@login_required
def export_products_excel():
    import pandas as pd
    import io
    from flask import send_file

    productos = Producto.query.order_by(Producto.id.desc()).all()

    # Crear DataFrame con los productos
    df = pd.DataFrame([{
        'ID': p.id,
        'Código': p.codigo,
        'Nombre': p.nombre,
        'Marca': p.marca,
        'Precio': f"S/. {p.precio:.2f}",
        'Estado': 'Activo' if p.activo else 'Inactivo'
    } for p in productos])

    # Guardar en un archivo Excel en memoria
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Productos')

    output.seek(0)

    # Enviar archivo al navegador
    return send_file(
        output,
        download_name="productos.xlsx",
        as_attachment=True,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )


@products.route('/editar/<int:product_id>', methods=['GET', 'POST'])
@login_required
def edit_product(product_id):
    producto = Producto.query.get_or_404(product_id)
    categorias = Categoria.query.order_by(Categoria.categoria).all()
    page = request.args.get('page', 1, type=int)

    if request.method == 'POST':
        producto.codigo       = request.form['codigo'].strip()
        producto.categoria_id = request.form['categoria_id']
        producto.nombre       = request.form['nombre'].strip()
        producto.marca        = request.form.get('marca', '').strip()
        producto.precio       = float(request.form['precio'])
        producto.activo       = bool(int(request.form['activo']))
        # Si editas imagen, agrégalo aquí

        try:
            db.session.commit()
            flash('Producto actualizado correctamente', 'success')
            return redirect(url_for('products.list_products', page=page))
        except Exception as e:
            db.session.rollback()
            flash(f'Error al actualizar producto: {e}', 'danger')

    return render_template(
        'products/edit.html',
        producto=producto,
        categorias=categorias,
        page=page
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



# ...
