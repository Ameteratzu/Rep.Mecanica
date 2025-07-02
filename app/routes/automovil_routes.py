
from flask import Blueprint, render_template, request, redirect, url_for, flash, send_file
from flask_login import login_required
from sqlalchemy.orm import joinedload

from app.models import (Automovil, Cliente)

from flask import jsonify

from app.extensions import db
import io
import pandas as pd
import os 

automovil_bp = Blueprint("automovil", __name__, url_prefix="/automoviles")

@automovil_bp.route('/', methods=['GET'])
@login_required
def listar_automoviles():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', '').strip()
    estado = request.args.get('estado', '')
    query = Automovil.query.options(joinedload(Automovil.cliente))
    clientes=Cliente.query
    if search:
        query = query.filter(
            (Automovil.placa.like(f'%{search}%')) |
            (Automovil.marca.like(f'%{search}%'))|
            (Automovil.modelo.like(f'%{search}%'))
        )
    if estado and estado != 'Todos':
        query = query.filter(Automovil.activo == (estado == 'Activo'))

    pagination = query.order_by(Automovil.id.desc()).paginate(page=page, per_page=10)
    automoviles = pagination.items
    
    
    return render_template(
        'automovil_pag/automovil_list.html',
        automoviles=automoviles,
        clientes=clientes,
        pagination=pagination,
        search=search,
        estado=estado
    )
@automovil_bp.route('/automovil/create', methods=['POST'])
def create_automovil():
    clientes=Cliente.query.all()
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
    return redirect(url_for('automovil.listar_automoviles'))

@automovil_bp.route('/automovil/update/<int:id>', methods=['POST'])
def update_automovil(id):
    automoviles = Automovil.query.get_or_404(id)
    try:
        automoviles.cliente_id = request.form['cliente_id']
        automoviles.placa = request.form['placa']
        automoviles.marca = request.form['marca']
        automoviles.modelo = request.form['modelo']
        automoviles.año = request.form.get('año') or None
        automoviles.color = request.form['color']
        activo = request.form.get('activo')
        if activo == '' or activo is None:
            automoviles.activo = None
        else:
            automoviles.activo = bool(int(activo))
        db.session.commit()
        flash('Automóvil actualizado exitosamente.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Error al actualizar el automóvil: {e}', 'danger')
    return redirect(url_for('automovil.listar_automoviles'))

@automovil_bp.route('/automovil/delete/<int:id>', methods=['POST'])
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
    
@automovil_bp.route("/eliminado_logico/<int:automovil_id>", methods=["POST"])
@login_required
def eliminado_logico(automovil_id):
    automovil = Automovil.query.get_or_404(automovil_id)
    automovil.activo = not automovil.activo
    db.session.commit()
    return redirect(url_for('automovil.listar_automoviles'))    

@automovil_bp.route('/exportar', methods=['GET'])
@login_required
def export_products_excel(): 

    automoviles = Automovil.query.order_by(Automovil.id.desc()).all()

    # Crear DataFrame con los productos
    df = pd.DataFrame([{
        'ID': a.id,
        'Placa': a.placa,
        'Marca': a.marca,
        'Modelo': a.modelo,
        'Cliente': f"{a.cliente.nombres} {a.cliente.apellidos}" if a.cliente else "SIN CLIENTE",
        'Año': a.año,
        'Color': a.color,
        'Estado': 'Activo' if a.activo else 'Inactivo'
    } for a in automoviles])

    # Guardar en un archivo Excel en memoria
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Productos')

    output.seek(0)

    # Enviar archivo al navegador
    return send_file(
        output,
        download_name="automoviles.xlsx",
        as_attachment=True,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
    
@automovil_bp.route('/buscar_automoviles')
def buscar_automoviles():
    term = request.args.get('term', '', type=str).strip()

    if term == '':
        autos = Automovil.query.limit(20).all()
    else:
        autos = Automovil.query.filter(
            (Automovil.placa.ilike(f'%{term}%')) |
            (Automovil.marca.ilike(f'%{term}%')) |
            (Automovil.modelo.ilike(f'%{term}%'))
        ).limit(20).all()

    resultado = []
    for a in autos:
        resultado.append({
            'id': a.id,
            'placa': a.placa,
            'marca': a.marca,
            'modelo': a.modelo
        })

    return jsonify(resultado)


