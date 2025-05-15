from flask_login import current_user

def is_admin():
    return current_user.is_authenticated and current_user.persona.rol.rol == "administrador"

def is_asistente():
    return current_user.is_authenticated and current_user.persona.rol.rol == "asistente"

def is_mecanico():
    return current_user.is_authenticated and current_user.persona.rol.rol == "mecánico"
