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
    
    # Relación con Cotización
    ventas_producto = db.relationship('VentaProducto', back_populates='producto', cascade='all, delete-orphan')
    
    def actualizar_costo_promedio(self, cantidad_nueva, costo_nuevo):
        from app.models.inventario import Inventario
        
        inventario = Inventario.query.filter_by(producto_id=self.id).first()
        if inventario:
            stock_actual = inventario.total_ingresos - inventario.total_egresos
            costo_actual = float(self.costo or 0)

            # Calcular el nuevo costo ponderado
            if (stock_actual + cantidad_nueva) > 0:
                nuevo_costo = (
                    (costo_actual * stock_actual) + (costo_nuevo * cantidad_nueva)
                ) / (stock_actual + cantidad_nueva)
            else:
                nuevo_costo = costo_nuevo  # Si no hay stock previo

            # Actualizar inventario y costo
            inventario.total_ingresos += cantidad_nueva
            self.costo = nuevo_costo

            db.session.commit()

    def __repr__(self):
        return f"<Producto {self.id} – {self.nombre}>"
