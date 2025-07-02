from app.extensions import db

class CotizacionEstado(db.Model):
    __tablename__ = 'cotizaciones_estados'
    
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), unique=True, nullable=False)
    
    ventas = db.relationship('Venta', back_populates='estado')

    def __repr__(self):
        return f"<CotizacionEstado {self.id} – {self.nombre}>"
