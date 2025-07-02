from app.extensions import db

class RolPermiso(db.Model):
    __tablename__ = 'rol_permiso'
    rol_id = db.Column(db.Integer, db.ForeignKey('roles.id'), primary_key=True)
    permiso_id = db.Column(db.Integer, db.ForeignKey('permisos.id'), primary_key=True)
