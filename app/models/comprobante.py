from app.extensions import db
from datetime import datetime

class Comprobante(db.Model):
    __tablename__ = "comprobantes"

    id         = db.Column(db.Integer, primary_key=True)
    orden_id   = db.Column(db.Integer, db.ForeignKey("ordenes.id"), nullable=False)
    total      = db.Column(db.Float, nullable=False)
    fecha      = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    orden      = db.relationship("Orden", backref="comprobantes")

    def __repr__(self):
        return f"<Comprobante {self.id} – Orden {self.orden_id} – Total {self.total}>"
