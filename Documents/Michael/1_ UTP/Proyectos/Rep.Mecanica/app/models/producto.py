from app.extensions import db

class Producto(db.Model):
    __tablename__ = 'productos'
    
    id           = db.Column(db.Integer, primary_key=True)
    codigo       = db.Column(db.String(50), nullable=False)
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias.id'))
    nombre       = db.Column(db.String(100), nullable=False)
    marca        = db.Column(db.String(50))
    costo        = db.Column(db.Numeric(10,2))
    precio       = db.Column(db.Numeric(10, 2))
    stock_minimo = db.Column(db.Integer)
    activo       = db.Column(db.Boolean, default=True)
    imagen       = db.Column(db.String(255))  # Ruta de la imagen

    # Relación con Categoría
    categoria    = db.relationship("Categoria", back_populates="productos")
    
    # Relación con Proveedor
    proveedores  = db.relationship('ProductoProveedor', 
                                   back_populates='producto', cascade='all, delete-orphan')
    
    # Relación con Ingreso (muchos a muchos)
    ingresos_productos = db.relationship("IngresoProducto", back_populates="producto", cascade='all, delete-orphan')

    def __repr__(self):
        return f"<Producto {self.id} – {self.nombre}>"
