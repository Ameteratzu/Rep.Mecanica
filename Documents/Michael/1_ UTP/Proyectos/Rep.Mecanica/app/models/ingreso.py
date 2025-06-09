from app.extensions import db
from app.models.proveedor import Proveedor

class Ingreso(db.Model):
    __tablename__ = 'ingresos'
    
    id = db.Column(db.Integer, primary_key=True)
    referencia = db.Column(db.String(100), nullable=False)
    guia = db.Column(db.String(100), nullable=False)
    concepto = db.Column(db.String(255), nullable=False)
    fecha = db.Column(db.Date, nullable=False)
    proveedor_id = db.Column(db.Integer, db.ForeignKey('proveedores.id'), nullable=False)
    total = db.Column(db.Numeric(12, 2), nullable=False)
    observacion = db.Column(db.Text)
    activo       = db.Column(db.Boolean, default=True)
    
    proveedor = db.relationship("Proveedor", back_populates="ingresos")
    
    ingresos_productos = db.relationship("IngresoProducto", back_populates="ingreso", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<Ingreso {self.id} - {self.referencia}>"
