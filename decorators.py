from flask import redirect, url_for, flash
from flask_login import current_user
from functools import wraps

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
