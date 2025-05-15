# app/modelsproducts.list_productso.py

from app.extensions import db

class Producto(db.Model):
    __tablename__ = "productos"

    id           = db.Column(db.Integer, primary_key=True, autoincrement=True)
    codigo       = db.Column(db.String(20), nullable=False)
    categoria_id = db.Column(
        db.Integer,
        db.ForeignKey("categorias.id"),  # referencia a la tabla 'categorias'
        nullable=False
    )
    marca        = db.Column(db.String(100), nullable=False)
    nombre       = db.Column(db.String(100), nullable=False)
    precio       = db.Column(db.Numeric(10, 2), nullable=False)
    imagen       = db.Column(db.String(50), nullable=True)
    activo       = db.Column(db.Boolean, default=True)

    # Relación con el modelo Categoria
    categoria    = db.relationship("Categoria", back_populates="productos")

    def __repr__(self):
        return f"<Producto {self.id} – {self.nombre}>"
