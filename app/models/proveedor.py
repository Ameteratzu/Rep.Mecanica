from app.extensions import db

class Proveedor(db.Model):
    __tablename__ = 'proveedores'
    
    id = db.Column(db.Integer, primary_key=True)
    ruc = db.Column(db.String(15))
    razon_social = db.Column(db.String(50))
    ubigeo_id = db.Column(db.Integer, db.ForeignKey('ubigeos.id'))
    direccion     = db.Column(db.String(50))
    telefono      = db.Column(db.String(20))
    correo      = db.Column(db.String(50))
    contacto      = db.Column(db.String(50))
    activo       = db.Column(db.Boolean, default=True)
    # Relación con Ubigeo
    ubigeo        = db.relationship("Ubigeo", back_populates="proveedores")
    
    # Relación con productos (muchos a muchos)
    productos     = db.relationship('ProductoProveedor',
                                    back_populates='proveedor', cascade='all, delete-orphan')
    
    # Relación con ingresos (uno a muchos)
    ingresos = db.relationship("Ingreso", back_populates="proveedor", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<Proveedor {self.id} – {self.razon_social}>"
    
    