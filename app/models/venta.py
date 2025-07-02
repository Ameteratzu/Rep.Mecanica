from app.extensions import db

class Venta(db.Model):
    __tablename__ = 'ventas'
    
    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(20), unique=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('clientes.id'), nullable=False)
    automovil_id = db.Column(db.Integer, db.ForeignKey('automoviles.id'), nullable=True)  # 🔧 Nuevo campo
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    estado_id = db.Column(db.Integer, db.ForeignKey('cotizaciones_estados.id'), nullable=False)
    
    fecha = db.Column(db.DateTime, server_default=db.func.current_timestamp())
    fecha_vencimiento = db.Column(db.Date)
    diagnostico = db.Column(db.Text)
    descuento_porcentaje = db.Column(db.Numeric(5, 2), default=0.00)
    subtotal = db.Column(db.Numeric(10, 2), default=0.00)
    descuento_monto = db.Column(db.Numeric(10, 2),default=0.00)
    total_sin_igv = db.Column(db.Numeric(10, 2), default=0.00)
    igv = db.Column(db.Numeric(10, 2), default=0.00)
    total = db.Column(db.Numeric(10, 2), default=0.00)
    observaciones = db.Column(db.Text)
    
    # Campos relacionados al comprobante
    comprobante_tipo = db.Column(db.String(10))  # Agregado si lo usas
    comprobante_estado = db.Column(db.Boolean)
    comprobante_serie = db.Column(db.String(5))
    comprobante_numero = db.Column(db.Integer)
    comprobante_fecha = db.Column(db.DateTime)
    comprobante_usuario_id = db.Column(db.Integer)

    # Campos relacionados a orden
    orden_estado = db.Column(db.String(20))
    orden_numero = db.Column(db.String(15))
    orden_fecha = db.Column(db.DateTime)
    orden_usuario_id = db.Column(db.Integer)
    
    # Relaciones
    estado = db.relationship('CotizacionEstado', back_populates='ventas')
    cliente = db.relationship('Cliente', back_populates='ventas')
    usuario = db.relationship('User', back_populates='ventas')
    automovil = db.relationship('Automovil', back_populates='ventas')  # 🔧 Relación útil
    
    productos = db.relationship('VentaProducto', back_populates='venta', cascade='all, delete-orphan')
    servicios = db.relationship('VentaServicio', back_populates='venta', cascade='all, delete-orphan')
    
    def __repr__(self):
        return f"<Venta {self.id} – Cliente {self.cliente_id}>"

    @classmethod
    def generar_codigo_cotizacion(cls):
        ultima_cotizacion = Venta.query.filter(Venta.codigo.like('C001-%')).order_by(Venta.id.desc()).first()

        if ultima_cotizacion and ultima_cotizacion.codigo:
            # Extrae el número después del guion
            ultimo_numero = int(ultima_cotizacion.codigo.split('-')[1])
        else:
            # Si no hay ninguna cotización aún
            ultimo_numero = 0

        nuevo_numero = ultimo_numero + 1
        cotizacion_codigo = f"C001-{nuevo_numero:08d}"
        return cotizacion_codigo

    @classmethod
    def generar_comprobante(cls, tipo: str = "Boleta"):
        """
        Genera una nueva serie y número correlativo para boleta o factura.

        :param tipo: "Boleta" o "Factura"
        :return: (serie, numero)
        """
        tipo_original = tipo  # ← Para guardar el valor original (con mayúscula)
        tipo = tipo.lower()   # ← Para comparar de forma segura

        if tipo == "boleta":
            serie = "B001"
        elif tipo == "factura":
            serie = "F001"
        else:
            raise ValueError("Tipo de comprobante inválido. Use 'Boleta' o 'Factura'.")

        ultima_venta = (
            cls.query.filter_by(comprobante_tipo=tipo_original)  # usamos tipo original (Boleta o Factura)
            .filter_by(comprobante_serie=serie)
            .order_by(cls.comprobante_numero.desc())
            .first()
        )

        if ultima_venta and ultima_venta.comprobante_numero:
            nuevo_numero = ultima_venta.comprobante_numero + 1
        else:
            nuevo_numero = 1

        return serie, nuevo_numero
