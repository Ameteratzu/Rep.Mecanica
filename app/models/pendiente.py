from app.extensions import db

class Pendiente(db.Model):
    __tablename__ = 'pendientes'
    id = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(120), nullable=False)
    descripcion = db.Column(db.Text)
    estado = db.Column(db.String(20), default="Pendiente")  # Pendiente, En Proceso, Completado
    fecha_creacion = db.Column(db.DateTime, server_default=db.func.now())
    fecha_limite = db.Column(db.Date)
