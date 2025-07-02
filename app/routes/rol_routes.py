from flask import Blueprint, render_template, request, jsonify, abort
from flask_login import login_required, current_user
from app.models.usuario import User
from app.models.rol import Rol
from app.models.permiso import Permiso
from app.models.rol_permiso import RolPermiso
from app.extensions import db

rol_bp = Blueprint('rol', __name__, url_prefix='/roles')

def es_admin():
    # Admin por email o por rol_id==3
    return current_user.is_authenticated and (
        current_user.rol_id == 3 or current_user.email == 'quispeamet2@gmail.com'
    )

# PANEL de usuarios y asignación de roles
@rol_bp.route('/usuarios', methods=['GET'])
@login_required
def usuarios_roles():
    if not es_admin():
        abort(403)
    usuarios = User.query.all()
    roles = Rol.query.filter_by(activo=True).all()
    return render_template('rol_pag/usuarios_roles.html', usuarios=usuarios, roles=roles)

@rol_bp.route('/usuarios/actualizar', methods=['POST'])
@login_required
def actualizar_rol_usuario():
    if not es_admin():
        abort(403)
    data = request.get_json()
    usuario_id = data.get('usuario_id')
    rol_id = data.get('rol_id')
    if not usuario_id or not rol_id:
        return jsonify(success=False, message="Datos incompletos"), 400
    usuario = User.query.get(usuario_id)
    if not usuario:
        return jsonify(success=False, message="Usuario no encontrado"), 404
    # Previene que el admin se baje a sí mismo
    if usuario.id == current_user.id and int(rol_id) != 3:
        return jsonify(success=False, message="No puedes quitarte tu propio rol de administrador"), 400
    usuario.rol_id = rol_id
    db.session.commit()
    return jsonify(success=True, message="Rol actualizado correctamente")

# CRUD de permisos (tablero visual)
@rol_bp.route('/permisos', methods=['GET'])
@login_required
def gestion_permisos():
    if not es_admin():
        abort(403)
    roles = Rol.query.filter_by(activo=True).all()
    permisos = Permiso.query.all()
    # SERIALIZAR para JS
    roles_json = [
        {"id": r.id, "rol": r.rol, "activo": r.activo} for r in roles
    ]
    return render_template(
        'rol_pag/gestion_permisos.html',
        roles=roles,
        roles_json=roles_json,
        permisos=permisos
    )



@rol_bp.route('/permisos/data', methods=['GET'])
@login_required
def obtener_permisos():
    if not es_admin():
        abort(403)
    rol_id = request.args.get('rol_id', type=int)
    permisos_ids = [rp.permiso_id for rp in RolPermiso.query.filter_by(rol_id=rol_id).all()]
    return jsonify(permisos=permisos_ids)

@rol_bp.route('/permisos/update', methods=['POST'])
@login_required
def actualizar_permisos():
    if not es_admin():
        abort(403)
    data = request.get_json()
    rol_id = int(data.get('rol_id'))
    permisos = list(map(int, data.get('permisos', [])))
    RolPermiso.query.filter_by(rol_id=rol_id).delete()
    for pid in permisos:
        db.session.add(RolPermiso(rol_id=rol_id, permiso_id=pid))
    db.session.commit()
    return jsonify(success=True)
