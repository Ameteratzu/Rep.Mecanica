from flask import Blueprint, render_template, request, redirect, url_for, flash, send_file, jsonify
from flask_login import login_required
from app.extensions import db
from sqlalchemy.orm import joinedload
from sqlalchemy import or_
from app.models.servicio import Servicio
import io
import pandas as pd


servicio_bp = Blueprint('servicio', __name__, url_prefix='/servicios')


@servicio_bp.route('/', methods=['GET'])
@login_required
def list_servicios():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', '').strip()
    estado = request.args.get('estado', 'Todos')

    query = Servicio.query

    if search:
        query = query.filter(
            (Servicio.codigo.like(f'%{search}%')) 
            (Servicio.nombre.like(f'%{search}%'))
        )

    if estado == 'Activo':
        query = query.filter_by(activo=True)
    elif estado == 'Inactivo':
        query = query.filter_by(activo=False)

    pagination = query.order_by(Servicio.id.desc()).paginate(page=page, per_page=10)
    servicios = pagination.items

    return render_template(
        'servicio_pag/servicio_list.html',
        servicios=servicios,
        pagination=pagination,
        search=search,
        estado=estado
    )


@servicio_bp.route('/nuevo', methods=['GET', 'POST'])
@login_required
def create_servicio():
    if request.method == 'POST':
        codigo = request.form['codigo'].strip()
        nombre = request.form['nombre'].strip()
        descripcion = request.form['descripcion'].strip()
        precio = request.form['precio']
        descuento = request.form['descuento']
        activo = request.form['activo'] == '1'

        errors = []

        if not codigo:
            errors.append("El código es obligatorio.")
        else:
            if Servicio.query.filter_by(codigo=codigo).first():
                errors.append("El código de servicio ya se encuentra registrado.")

        if not nombre:
            errors.append("El nombre es obligatorio.")

        if not descripcion:
            errors.append("La descripción es obligatoria.")

        try:
            precio_val = float(precio)
            if precio_val < 0:
                errors.append("El precio debe ser un número positivo.")
        except ValueError:
            errors.append("El precio debe ser un número válido.")

        try:
            descuento_val = float(descuento)
            if descuento_val < 0:
                errors.append("El descuento debe ser un número positivo.")
        except ValueError:
            errors.append("El descuento debe ser un número válido.")

        if errors:
            for error in errors:
                flash(error, 'danger')
            return render_template('servicio_pag/servicio_form.html', servicio=request.form)

        try:
            servicio = Servicio(
                codigo=codigo,
                nombre=nombre,
                descripcion=descripcion,
                precio=precio_val,
                descuento=descuento_val,
                activo=activo
            )
            db.session.add(servicio)
            db.session.commit()
            flash('Servicio creado correctamente', 'success')
            return redirect(url_for('servicio.list_servicios'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error al crear servicio: {e}', 'danger')

    return render_template('servicio_pag/servicio_form.html', servicio={})


@servicio_bp.route('/editar/<int:servicio_id>', methods=['GET', 'POST'])
@login_required
def edit_servicio(servicio_id):
    servicio = Servicio.query.get_or_404(servicio_id)

    if request.method == 'POST':
        codigo = request.form['codigo'].strip()
        nombre = request.form['nombre'].strip()
        descripcion = request.form['descripcion'].strip()
        precio = request.form['precio']
        descuento = request.form['descuento']
        activo = request.form['activo'] == '1'

        errors = []

        if not codigo:
            errors.append("El código es obligatorio.")
        else:
            otro = Servicio.query.filter(Servicio.codigo == codigo, Servicio.id != servicio_id).first()
            if otro:
                errors.append("El código de servicio ya se encuentra registrado.")

        if not nombre:
            errors.append("El nombre es obligatorio.")

        if not descripcion:
            errors.append("La descripción es obligatoria.")

        try:
            precio_val = float(precio)
            if precio_val < 0:
                errors.append("El precio debe ser un número positivo.")
        except ValueError:
            errors.append("El precio debe ser un número válido.")

        try:
            descuento_val = float(descuento)
            if descuento_val < 0:
                errors.append("El descuento debe ser un número positivo.")
        except ValueError:
            errors.append("El descuento debe ser un número válido.")

        if errors:
            for error in errors:
                flash(error, 'danger')
            servicio_temp = request.form.to_dict()
            servicio_temp['id'] = servicio_id
            return render_template('servicio_pag/servicio_form.html', servicio=servicio_temp)

        try:
            servicio.codigo = codigo
            servicio.nombre = nombre
            servicio.descripcion = descripcion
            servicio.precio = precio_val
            servicio.descuento = descuento_val
            servicio.activo = activo
            db.session.commit()
            flash('Servicio actualizado correctamente', 'success')
            return redirect(url_for('servicio.list_servicios'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error al actualizar servicio: {e}', 'danger')

    return render_template('servicio_pag/servicio_form.html', servicio=servicio)

@servicio_bp.route('/eliminar/<int:servicio_id>', methods=['POST'])
@login_required
def eliminar_servicio(servicio_id):
    servicio = Servicio.query.get_or_404(servicio_id)
    try:
        db.session.delete(servicio)
        db.session.commit()
        flash('Servicio eliminado correctamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al eliminar el servicio: {e}', 'danger')
    return redirect(url_for('servicio.list_servicios'))

@servicio_bp.route('/export', methods=['GET'])
@login_required
def export_excel():
    servicios = Servicio.query.all()
    #para exportar DataFrame
    df = pd.DataFrame([{
        'ID': s.id,
        'Código': s.codigo,
        'Nombre': s.nombre,
        'Descripción': s.descripcion,
        'Descuento (%)': float(s.descuento), 
        'Precio': float(s.precio),
        'Activo': 'Sí' if s.activo else 'No'
    } for s in servicios])

    #crear salida
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Servicios')

    output.seek(0)
    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_name='servicios.xlsx',
        as_attachment=True
    )
    
@servicio_bp.route('/buscar_servicios', methods=['GET'])
@login_required
def buscar_servicios():
    term = request.args.get('term', '', type=str).strip()

    if term == '':
        servicios = Servicio.query.limit(20).all()
    else:
        servicios = Servicio.query.filter(
            (Servicio.codigo.ilike(f'%{term}%')) |
            (Servicio.nombre.ilike(f'%{term}%')) |
            (Servicio.descripcion.ilike(f'%{term}%'))
        ).limit(20).all()

    resultado = []
    for s in servicios:
        resultado.append({
            'id': s.id,
            'codigo': s.codigo,
            'nombre': s.nombre,
            'precio': float(s.precio or 0),
        })

    return jsonify(resultado)
    