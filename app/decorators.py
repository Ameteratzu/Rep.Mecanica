from flask import redirect, url_for, flash
from flask_login import current_user
from functools import wraps
from app.models.permiso import Permiso
from app.models.rol_permiso import RolPermiso

def roles_requeridos(*roles):
    def wrapper(fn):
        @wraps(fn)
        def decorated_view(*args, **kwargs):
            if not current_user.is_authenticated:
                return redirect(url_for('main.login'))
            # Acceso al rol desde Persona
            user_rol = current_user.persona.rol.rol
            if user_rol not in roles:
                flash("No tienes permiso para acceder a esta sección.", "danger")
                return redirect(url_for('main.dashboard'))
            return fn(*args, **kwargs)
        return decorated_view
    return wrapper

def permiso_requerido(slug):
    def decorator(fn):
        @wraps(fn)
        def decorated_function(*args, **kwargs):
            if not current_user.is_authenticated:
                return redirect(url_for('main.login'))
            # Super admin por email siempre puede acceder
            if getattr(current_user, 'email', None) == 'quispeamet2@gmail.com':
                return fn(*args, **kwargs)
            permiso = Permiso.query.filter_by(slug=slug).first()
            if not permiso:
                flash("Permiso no válido.", "danger")
                return redirect(url_for('main.dashboard'))
            tiene_permiso = RolPermiso.query.filter_by(
                rol_id=current_user.rol_id,
                permiso_id=permiso.id
            ).first()
            if not tiene_permiso:
                flash("No tienes permiso para acceder a esta sección.", "danger")
                return redirect(url_for('main.dashboard'))
            return fn(*args, **kwargs)
        return decorated_function
    return decorator
