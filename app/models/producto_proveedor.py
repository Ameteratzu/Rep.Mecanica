from app.extensions import db

class ProductoProveedor(db.Model):
    __tablename__ = 'productos_proveedores'
    
    id            = db.Column(db.Integer, primary_key=True)
    producto_id   = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False)
    proveedor_id  = db.Column(db.Integer, db.ForeignKey('proveedores.id'), nullable=False)

    producto      = db.relationship('Producto', back_populates='proveedores')
    proveedor     = db.relationship('Proveedor', back_populates='productos')

    def __repr__(self):
        return f"<ProductoProveedor {self.id}>"