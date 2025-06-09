from app.extensions import db
from datetime import datetime

class Log(db.Model):
    __tablename__ = 'logs'
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'))
    accion = db.Column(db.String(200))
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    usuario = db.relationship('User', backref='logs')
