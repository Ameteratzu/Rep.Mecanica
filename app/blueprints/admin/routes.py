from flask import Blueprint, render_template
from flask_login import login_required, current_user
from app.decorators import roles_requeridos
from app.models.usuario import User
from app.models.rol import Rol
from app.models.producto import Producto
from app.models.servicio import Servicio
from app.models.cliente import Cliente
from app.models.comprobante import Comprobante
from app.models.orden import Orden  # Ajusta el import según tu estructura
from app.models.log import Log
from sqlalchemy import desc

admin_panel_bp = Blueprint('admin_panel', __name__)

@admin_panel_bp.route('/admin/panel')
@login_required
@roles_requeridos('administrador')
def admin_panel():
    total_usuarios = User.query.count()
    total_roles = Rol.query.count()
    total_productos = Producto.query.count()
    total_servicios = Servicio.query.count()
    total_clientes = Cliente.query.count()
    total_comprobantes = Comprobante.query.count()
    total_ordenes = Orden.query.count()
    ultimos_usuarios = User.query.order_by(User.id.desc()).limit(7).all()
    ultimos_productos = Producto.query.order_by(Producto.id.desc()).limit(5).all()
    ultimos_logs = Log.query.order_by(desc(Log.timestamp)).limit(10).all()
    return render_template(
        'admin/panel.html',
        total_usuarios=total_usuarios,
        total_roles=total_roles,
        total_productos=total_productos,
        total_servicios=total_servicios,
        total_clientes=total_clientes,
        total_comprobantes=total_comprobantes,
        total_ordenes=total_ordenes,
        ultimos_usuarios=ultimos_usuarios,
        ultimos_productos=ultimos_productos,
        ultimos_logs=ultimos_logs
    )
