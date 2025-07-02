from flask import Blueprint, render_template, request, jsonify
from flask_login import login_required
from app.decorators import permiso_requerido
from app.models.pendiente import Pendiente
from app.extensions import db

pendiente_bp = Blueprint('pendiente', __name__, url_prefix='/pendientes')

@pendiente_bp.route('/')
@login_required
@permiso_requerido('pendientes')
def listar_pendientes():
    pendientes = Pendiente.query.order_by(Pendiente.id.desc()).all()
    return render_template('pendiente_pag/pendiente_list.html', pendientes=pendientes)

@pendiente_bp.route('/crear', methods=['POST'])
@login_required
@permiso_requerido('pendientes')
def crear_pendiente():
    data = request.form
    p = Pendiente(
        titulo=data['titulo'],
        descripcion=data.get('descripcion'),
        estado=data.get('estado', 'Pendiente'),
        fecha_limite=data.get('fecha_limite') or None
    )
    db.session.add(p)
    db.session.commit()
    return jsonify(success=True, id=p.id)

@pendiente_bp.route('/<int:id>/editar', methods=['POST'])
@login_required
@permiso_requerido('pendientes')
def editar_pendiente(id):
    p = Pendiente.query.get_or_404(id)
    data = request.form
    p.titulo = data['titulo']
    p.descripcion = data.get('descripcion')
    p.estado = data.get('estado', 'Pendiente')
    p.fecha_limite = data.get('fecha_limite') or None
    db.session.commit()
    return jsonify(success=True)

@pendiente_bp.route('/<int:id>/borrar', methods=['POST'])
@login_required
@permiso_requerido('pendientes')
def borrar_pendiente(id):
    p = Pendiente.query.get_or_404(id)
    db.session.delete(p)
    db.session.commit()
    return jsonify(success=True)
