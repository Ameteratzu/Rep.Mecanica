from flask import (
    Blueprint, render_template, request, redirect,
    url_for, flash, Response, send_file, jsonify
)
from flask_login import login_required
from werkzeug.utils import secure_filename

from app.extensions import db
from app.models.producto import Producto
from app.models.categoria import Categoria  # ✅ correcto

from sqlalchemy.orm import joinedload
from sqlalchemy import or_

import os
import io
import pandas as pd



producto_bp = Blueprint("producto", __name__, url_prefix="/productos")


@producto_bp.route('/', methods=['GET'])
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
        'producto_pag/producto_list.html',
        productos=productos,
        pagination=pagination,
        search=search,
        estado=estado,categorias=categorias
    )

@producto_bp.route('/exportar', methods=['GET'])
@login_required
def export_products_excel(): 

    productos = Producto.query.order_by(Producto.id.desc()).all()

    # Crear DataFrame con los productos
    df = pd.DataFrame([{
        'ID': p.id,
        'Código': p.codigo,
        'Nombre': p.nombre,
        'Marca': p.marca,
        'Costo': f"S/. {p.costo:.2f}",
        'Precio': f"S/. {p.precio:.2f}",
        'stock_minimo': p.stock_minimo,
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


@producto_bp.route('/editar/<int:product_id>', methods=['GET', 'POST'])
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
        producto.costo        = float(request.form['costo'])
        producto.precio       = float(request.form['precio'])
        producto.stock_minimo = int(request.form['stock_minimo'])
        producto.activo       = bool(int(request.form['activo']))
        # Si editas imagen, agrégalo aquí

        try:
            db.session.commit()
            flash('Producto actualizado correctamente', 'success')
            return redirect(url_for('producto.list_products', page=page))
        except Exception as e:
            db.session.rollback()
            flash(f'Error al actualizar producto: {e}', 'danger')

    return render_template(
        'producto_pag/producto_edit.html',
        producto=producto,
        categorias=categorias,
        page=page
    )


@producto_bp.route('/<int:product_id>/eliminar', methods=['POST'])
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
    return redirect(url_for('producto.list_products', page=page))



@producto_bp.route('/nuevo', methods=['POST'])
@login_required
def create_product():
    codigo       = request.form['codigo']
    categoria_id = request.form['categoria_id']
    nombre       = request.form['nombre']
    marca        = request.form.get('marca', '')
    costo       = request.form['costo']
    precio       = request.form['precio']
    stock_minimo = request.form['stock_minimo']
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
        costo=costo,
        precio=precio,
        stock_minimo=stock_minimo,
        activo=activo,
        imagen=filename  # Solo si tu modelo tiene el campo imagen
    )
    db.session.add(nuevo_producto)
    db.session.commit()
    flash('Producto agregado correctamente', 'success')
    return redirect(url_for('producto.list_products'))

@producto_bp.route('/cambiar_estado/<int:product_id>', methods=['POST'])
@login_required
def cambiar_estado(product_id):
    producto = Producto.query.get_or_404(product_id)
    producto.activo = not producto.activo
    db.session.commit()
    return redirect(url_for('producto.list_products'))

#Buscar producto para ingresos
@producto_bp.route('/buscar_productos', methods=['GET'])
@login_required
def buscar_productos():
    term = request.args.get('term', '', type=str).strip()
    
    if term == '':
        # Si no hay término de búsqueda, devuelvo todos los clientes
        Productos = Producto.query.limit(20).all()
    else:
        Productos = Producto.query.filter(
            (Producto.codigo.ilike(f'%{term}%')) | 
            (Producto.nombre.ilike(f'%{term}%')) |
            (Producto.marca.ilike(f'%{term}%')) |
            (Categoria.categoria.ilike(f'%{term}%'))
        ).limit(20).all()

    resultado = []
    for p in Productos:
        resultado.append({
            'id': p.id,
            'codigo': p.codigo,
            'nombre': p.nombre,
            'marca': p.marca,
            'stock': p.inventario.stock if p.inventario else 0,
            'costo': float(p.costo or 0),
            'precio': float(p.precio or 0),
            'categoria': p.categoria.categoria if p.categoria else ''
        })

    return jsonify(resultado)

    