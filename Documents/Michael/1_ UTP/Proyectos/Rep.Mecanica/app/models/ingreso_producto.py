from app.extensions import db
from app.models.ingreso import Ingreso
from app.models.producto import Producto

class IngresoProducto(db.Model):
    __tablename__ = 'ingresos_productos'
    
    id = db.Column(db.Integer, primary_key=True)
    ingreso_id = db.Column(db.Integer, db.ForeignKey('ingresos.id'), nullable=False)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False)
    cantidad = db.Column(db.Integer, nullable=False)
    costo = db.Column(db.Numeric(12, 2), nullable=False)
    total = db.Column(db.Numeric(12, 2), nullable=False)
    
    ingreso = db.relationship("Ingreso", back_populates="ingresos_productos")
    producto = db.relationship("Producto", back_populates="ingresos_productos")

    def __repr__(self):
        return f"<IngresoProducto {self.id} - Producto {self.producto_id} - Cantidad {self.cantidad}>"
