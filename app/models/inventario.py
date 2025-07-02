from app.extensions import db
from app.models.producto import Producto
from app.models.ingreso import Ingreso

from app.models.venta import Venta
from sqlalchemy import Computed, func




class Inventario(db.Model):
    __tablename__ = 'inventario'
    id = db.Column(db.Integer, primary_key=True)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False)
    total_ingresos = db.Column(db.Integer, default=0)
    total_egresos = db.Column(db.Integer, default=0)
    total_ventas = db.Column(db.Integer, default=0)
    stock = db.Column(db.Integer, Computed("total_ingresos - total_egresos - total_ventas"), nullable=False)

    producto = db.relationship('Producto', backref=db.backref('inventario', uselist=False))

    @classmethod
    def actualizar_inventario(cls,producto_id):
        
        from app.models.ingreso_producto import IngresoProducto
        from app.models.venta_producto import VentaProducto
        
        total_ingresos = db.session.query(
            func.coalesce(func.sum(IngresoProducto.cantidad), 0)
        ).join(Ingreso, IngresoProducto.ingreso_id == Ingreso.id) \
        .filter(IngresoProducto.producto_id == producto_id) \
        .filter(Ingreso.activo == True) \
        .scalar()        
      
        total_ventas=VentaProducto.total_vendido_por_producto(producto_id)

        # Por ahora no hay egresos, pero aquí iría la suma cuando tengas el modelo:
        # total_egresos = db.session.query(
        #     func.coalesce(func.sum(EgresoProducto.cantidad), 0)
        # ).filter(EgresoProducto.producto_id == producto_id).scalar()
        
        total_egresos = 0  # Mientras tanto lo dejamos en cero      


        inventario = Inventario.query.filter_by(producto_id=producto_id).first()
        if not inventario:
            inventario = Inventario(producto_id=producto_id)
            db.session.add(inventario)

        inventario.total_ingresos = total_ingresos
        inventario.total_egresos = total_egresos
        inventario.total_ventas = total_ventas

        db.session.commit()

    @classmethod
    def actualizar_todo_el_inventario(cls):
        from app.models.producto import Producto

        productos = Producto.query.all()
        for producto in productos:
            cls.actualizar_inventario(producto.id)
            