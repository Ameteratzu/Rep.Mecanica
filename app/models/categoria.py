# app/models/categoria.py

from app.extensions import db

class Categoria(db.Model):
    __tablename__ = "categorias"

    id         = db.Column(db.Integer, primary_key=True, autoincrement=True)
    categoria  = db.Column(db.String(50), nullable=False)
    activo     = db.Column(db.Boolean, default=True)

    # Relación inversa: todos los productos de esta categoría
    productos  = db.relationship("Producto", back_populates="categoria")

    def __repr__(self):
        return f"<Categoria {self.id} – {self.categoria}>"
