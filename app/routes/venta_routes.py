from flask import Blueprint, render_template, request, redirect, url_for, flash, send_file,jsonify
from flask_login import login_required, current_user
from sqlalchemy.orm import joinedload
from app.extensions import db
from datetime import datetime

from app.models import (
    Venta, User, Cliente, Automovil, Producto, Servicio,
    CotizacionEstado, VentaServicio, VentaProducto, Inventario
)
import re
import pandas as pd
import io
from datetime import datetime

cotizacion_bp = Blueprint("cotizacion", __name__,url_prefix="/cotizaciones")

@cotizacion_bp.route("/", methods=['GET'])
@login_required
def listar_cotizaciones():
    # ✅ Actualiza todo el inventario
    Inventario.actualizar_todo_el_inventario()
    boleta_tentativa = Venta.generar_comprobante('Boleta')
    factura_tentativa = Venta.generar_comprobante('Factura')
    
    search = request.args.get('search','').strip()
    estado =request.args.get('estado', 'Activo')
    page = request.args.get('page', 1,type=int)
    
    query = Venta.query \
    .options(
        joinedload(Venta.cliente),
        joinedload(Venta.automovil),
        joinedload(Venta.estado),
        joinedload(Venta.usuario)
    )    
    if search:
        query = query.filter(
            (Venta.codigo.like(f'%{search}%')) |
            (Venta.fecha.like(f'%{search}%'))|
            (Venta.fecha_vencimiento.like(f'%{search}%'))
        )
    query = query.order_by(Venta.id.desc())
    pagination = query.paginate(page=page, per_page=10)
    cotizaciones = pagination.items
    
    clientes = Cliente.query.filter_by(activo=True).all()
    automoviles = Automovil.query.all()
    servicios = Servicio.query.all()
    productos = Producto.query.all()
    estados = CotizacionEstado.query.all()
    codigo_tentativo = Venta.generar_codigo_cotizacion()
    
    return render_template(
        "cotizacion_pag/cotizacion_list.html",
        cotizaciones=cotizaciones,
        pagination=pagination,
        search=search,
        clientes=clientes,
        automoviles=automoviles,
        servicios=servicios,
        productos=productos,
        estados=estados,
        codigo_tentativo=codigo_tentativo,
        boleta_tentativa=boleta_tentativa,
        factura_tentativa=factura_tentativa        
    )
    
@cotizacion_bp.route("/nueva", methods=["GET", "POST"])
@login_required
def nueva_cotizacion():
    if request.method == "POST":
        try:
            es_fetch = request.headers.get("X-Requested-With") == "XMLHttpRequest"

            # --- DATOS GENERALES ---
            codigo = Venta.generar_codigo_cotizacion()
            fecha_vencimiento = request.form.get("fecha_vencimiento")
            diagnostico = request.form.get("diagnostico")
            cliente_id = request.form.get("cliente_id")
            automovil_id = request.form.get("automovil_id") or None
            observaciones = request.form.get("observaciones")
            estado_id = request.form.get("estado_id")
            descuento_global = float(request.form.get("descuento", 0))

            subtotal = 0.0
            productos = []
            servicios = []

            # --- PRODUCTOS ---
            productos_form = {}
            for key in request.form:
                if key.startswith("productos["):
                    import re
                    m = re.match(r"productos\[(\d+)\]\[(\w+)\]", key)
                    if m:
                        idx = int(m.group(1))
                        field = m.group(2)
                        productos_form.setdefault(idx, {})[field] = request.form.get(key)

            for idx, p in productos_form.items():
                producto_id = int(p.get("id"))
                nombre = p.get("nombre", "")
                cantidad = int(p.get("cantidad", 1))
                precio_unitario = float(p.get("precio", 0))
                descuento_porcentaje = float(p.get("descuento", 0))
                costo = float(p.get("costo", 0))
                descuento_monto = round(precio_unitario * descuento_porcentaje / 100, 2)
                subtotal += (precio_unitario - descuento_monto) * cantidad

                productos.append(VentaProducto(
                    producto_id=producto_id,
                    descripcion=nombre,
                    cantidad=cantidad,
                    precio_unitario=precio_unitario,
                    descuento_porcentaje=descuento_porcentaje,
                    descuento_monto=descuento_monto,
                    costo=costo
                ))

            # --- SERVICIOS ---
            servicios_form = {}
            for key in request.form:
                if key.startswith("servicios["):
                    import re
                    m = re.match(r"servicios\[(\d+)\]\[(\w+)\]", key)
                    if m:
                        idx = int(m.group(1))
                        field = m.group(2)
                        servicios_form.setdefault(idx, {})[field] = request.form.get(key)

            for idx, s in servicios_form.items():
                servicio_id = int(s.get("id"))
                nombre = s.get("nombre", "")
                cantidad = int(s.get("cantidad", 1))
                precio_unitario = float(s.get("precio", 0))
                descuento_porcentaje = float(s.get("descuento", 0))
                descuento_monto = round(precio_unitario * descuento_porcentaje / 100, 2)
                subtotal += (precio_unitario - descuento_monto) * cantidad

                servicios.append(VentaServicio(
                    servicio_id=servicio_id,
                    descripcion=nombre,
                    cantidad=cantidad,
                    precio_unitario=precio_unitario,
                    descuento_monto=descuento_monto,
                    descuento_porcentaje=descuento_porcentaje
                ))

            # --- CÁLCULOS FINALES ---
            total_descuento_global = round(subtotal * (descuento_global / 100), 2)
            total_sin_igv = round(subtotal - total_descuento_global, 2)
            igv = round(total_sin_igv * 0.18, 2)
            total = round(total_sin_igv + igv, 2)

            # --- GUARDAR EN BD ---
            venta = Venta(
                codigo=codigo,
                cliente_id=cliente_id,
                automovil_id=automovil_id,
                usuario_id=current_user.id,
                estado_id=estado_id,
                fecha_vencimiento=fecha_vencimiento,
                diagnostico=diagnostico,
                observaciones=observaciones,
                descuento_porcentaje=descuento_global,
                subtotal=subtotal,
                descuento_monto=total_descuento_global,
                total_sin_igv=total_sin_igv,
                igv=igv,
                total=total
            )

            db.session.add(venta)
            db.session.flush()  # Para obtener venta.id

            for cp in productos:
                cp.venta_id = venta.id
                db.session.add(cp)

            for cs in servicios:
                cs.venta_id = venta.id
                db.session.add(cs)

            db.session.commit()

            # 🔁 VERIFICAR EL TIPO DE RESPUESTA
            if es_fetch:
                return jsonify({"success": True, "venta_id": venta.id})
            else:
                flash("Cotización registrada exitosamente", "success")
                return redirect(url_for("cotizacion.listar_cotizaciones"))

        except Exception as e:
            import traceback
            traceback.print_exc()
            db.session.rollback()
            if request.headers.get("X-Requested-With") == "XMLHttpRequest":
                return jsonify({"success": False, "error": str(e)}), 500
            else:
                flash(f"Error al guardar cotización: {e}", "danger")
                return render_template("cotizacion_pag/nueva_cotizacion.html")

    # --- GET ---
    clientes = Cliente.query.all()
    productos = Producto.query.all()
    servicios = Servicio.query.all()
    automoviles = Automovil.query.all()
    estados = CotizacionEstado.query.all()
    codigo_tentativo = Venta.generar_codigo_cotizacion()

    return render_template("cotizacion_pag/nueva_cotizacion.html",
                           clientes=clientes,
                           productos=productos,
                           servicios=servicios,
                           automoviles=automoviles,
                           estados=estados,
                           codigo_tentativo=codigo_tentativo)

    
@cotizacion_bp.route('/eliminado_logico/<int:venta_id>', methods=['POST'])
@login_required
def eliminado_logico(venta_id):
    venta = Venta.query.get_or_404(venta_id)
    
    # Verificar si ya está anulada
    if venta.estado.nombre == 'Anulada':
        flash("La cotización ya está anulada.", "warning")
        return redirect(url_for('cotizacion.list_cotizaciones'))

    # Buscar el estado 'Anulada'
    estado_anulado = CotizacionEstado.query.filter_by(nombre='Anulada').first()
    if not estado_anulado:
        flash("El estado 'Anulada' no está configurado en la base de datos.", "danger")
        return redirect(url_for('cotizacion.list_cotizaciones'))

    # Cambiar el estado
    venta.estado_id = estado_anulado.id

    try:
        db.session.commit()
        flash("La cotización ha sido anulada correctamente.", "success")
    except Exception as e:
        db.session.rollback()
        flash(f"No se pudo anular la cotización: {e}", "danger")

    return redirect(url_for('cotizacion.listar_cotizaciones'))

@cotizacion_bp.route("/obtener/<int:id>")
@login_required
def obtener_cotizacion(id):
    venta = Venta.query.get_or_404(id)

    # Filtrar solo productos y servicios activos (si usas soft-delete)
    productos_activos = [cp for cp in venta.productos if getattr(cp, "activo", True)]
    servicios_activos = [cs for cs in venta.servicios if getattr(cs, "activo", True)]

    data = {
        "id": venta.id,
        "codigo": venta.codigo,
        "fecha": venta.fecha.strftime('%Y-%m-%d'),
        "fecha_vencimiento": venta.fecha_vencimiento.strftime('%Y-%m-%d') if venta.fecha_vencimiento else "",
        "estado_id": venta.estado_id,
        "cliente": {
            "id": venta.cliente.id,
            "documento": venta.cliente.documento,
            "nombre": f"{venta.cliente.nombres} {venta.cliente.apellidos}",
            "celular": venta.cliente.celular
        },
        "automovil": {
            "id": venta.automovil.id,
            "placa": venta.automovil.placa,
            "detalle": f"{venta.automovil.marca} {venta.automovil.modelo}"
        },
        "diagnostico": venta.diagnostico,
        "observaciones": venta.observaciones,
        "descuento_porcentaje": float(venta.descuento_porcentaje or 0),
        "subtotal": float(venta.subtotal),
        "descuento_monto": float(venta.descuento_monto or 0),
        "total_sin_igv": float(venta.total_sin_igv or 0),
        "igv": float(venta.igv or 0),
        "total": float(venta.total or 0),
        
            
        "productos": [
            {
                "id": cp.producto.id,
                "codigo": cp.producto.codigo,
                "nombre": cp.producto.nombre,
                "precio": float(cp.precio_unitario),
                "cantidad": cp.cantidad,
                "descuento_porcentaje": float(cp.descuento_porcentaje or 0),
                "costo": float(cp.costo or 0),
                "subtotal": float((cp.precio_unitario - cp.descuento_monto) * (cp.cantidad or 0))
            }
            for cp in productos_activos
        ],
        "servicios": [
            {
                "id": cs.servicio.id,
                "codigo": cs.servicio.codigo,
                "nombre": cs.servicio.nombre,
                "descripcion": cs.servicio.descripcion,
                "precio": float(cs.precio_unitario),
                "cantidad": cs.cantidad,
                "descuento_porcentaje": float(cs.descuento_porcentaje or 0),
                "subtotal": float((cs.precio_unitario - cs.descuento_monto) * (cs.cantidad or 0))
            }
            for cs in servicios_activos
        ],
        "total_productos": sum(
            (cp.precio_unitario - cp.descuento_monto) * cp.cantidad
            for cp in productos_activos
        ),
        "total_servicios": sum(
            (cs.precio_unitario - cs.descuento_monto) * cs.cantidad
            for cs in servicios_activos
        )
        
    }

    return jsonify(data)


@cotizacion_bp.route("/editar/<int:venta_id>", methods=["POST"])
@login_required
def editar_cotizacion(venta_id):
    venta = Venta.query.get_or_404(venta_id)

    try:
        # DATOS GENERALES ACTUALIZADOS
        venta.fecha_vencimiento = request.form.get("fecha_vencimiento")
        venta.diagnostico = request.form.get("diagnostico")
        venta.observaciones = request.form.get("observaciones")
        venta.estado_id = request.form.get("estado_id")
        venta.cliente_id = request.form.get("cliente_id")
        venta.automovil_id = request.form.get("automovil_id") or None        
        descuento_global           = float(request.form.get("descuento", 0))
        venta.descuento_porcentaje = float(request.form.get("descuento", 0))
        
        

        # VARIABLES DE CÁLCULO
        subtotal = 0.0
        productos = []
        servicios = []

        # ====================
        # PRODUCTOS
        # ====================
                # ====================
        # PRODUCTOS → parsear formulario
        # ====================
        productos_form = {}
        for key in request.form:
            if key.startswith("productos["):
                m = re.match(r"productos\[(\d+)\]\[(\w+)\]", key)
                if m:
                    idx = int(m.group(1))
                    field = m.group(2)
                    productos_form.setdefault(idx, {})[field] = request.form.get(key)

        # — Desactivar en BD solo los productos que YA NO están en el formulario
        sent_product_ids = {
            int(p["id"])
            for p in productos_form.values()
            if p.get("id")
        }
        for vp in VentaProducto.query.filter_by(venta_id=venta.id, activo=True):
            if vp.producto_id not in sent_product_ids:
                vp.activo = False

        # — Ahora reconstruye la lista de objetos para agregar o reactivar
        for idx, p in productos_form.items():
            producto_id     = int(p.get("id"))
            nombre          = p.get("nombre", "")
            cantidad        = int(p.get("cantidad", 1))
            precio_unitario = float(p.get("precio", 0))
            descuento_pct   = float(p.get("descuento", 0))
            costo           = float(p.get("costo", 0))

            descuento_monto = round((precio_unitario * descuento_pct / 100) * cantidad, 2)
            subtotal += (precio_unitario * cantidad) - descuento_monto

            productos.append(VentaProducto(
                venta_id=venta.id,
                producto_id=producto_id,
                descripcion=nombre,
                cantidad=cantidad,
                precio_unitario=precio_unitario,
                descuento_monto=descuento_monto,
                costo=costo
            ))

        # ====================
        # SERVICIOS → parsear formulario
        # ====================
        servicios_form = {}
        for key in request.form:
            if key.startswith("servicios["):
                m = re.match(r"servicios\[(\d+)\]\[(\w+)\]", key)
                if m:
                    idx = int(m.group(1))
                    field = m.group(2)
                    servicios_form.setdefault(idx, {})[field] = request.form.get(key)

        # — Desactivar en BD solo los servicios que YA NO están en el formulario
        sent_service_ids = {
            int(s["id"])
            for s in servicios_form.values()
            if s.get("id")
        }
        for vs in VentaServicio.query.filter_by(venta_id=venta.id, activo=True):
            if vs.servicio_id not in sent_service_ids:
                vs.activo = False

        # — Ahora reconstruye la lista de objetos para agregar o reactivar
        for idx, s in servicios_form.items():
            servicio_id     = int(s.get("id"))
            nombre          = s.get("nombre", "")
            cantidad        = int(s.get("cantidad", 1))
            precio_unitario = float(s.get("precio", 0))
            descuento_pct   = float(s.get("descuento", 0))

            descuento_monto = round((precio_unitario * descuento_pct / 100) * cantidad, 2)
            subtotal += (precio_unitario * cantidad) - descuento_monto

            servicios.append(VentaServicio(
                venta_id=venta.id,
                servicio_id=servicio_id,
                descripcion=nombre,
                cantidad=cantidad,
                precio_unitario=precio_unitario,
                descuento_monto=descuento_monto
            ))


        # ====================
        # CALCULOS FINALES
        # ====================
        # Usamos la variable descuento_global capturada arriba
        total_descuento_global = round(subtotal * (descuento_global / 100), 2)
        total_sin_igv           = round(subtotal - total_descuento_global, 2)
        igv                     = round(total_sin_igv * 0.18, 2)
        total                   = round(total_sin_igv + igv, 2)

        venta.subtotal          =subtotal
        venta.descuento_monto   = total_descuento_global
        venta.total_sin_igv     = total_sin_igv
        venta.igv               = igv
        venta.total             = total

        # ====================
        # Para hacer una Venta
        # ====================      

        # ✅ Generar comprobante si la acción es "realizar_venta"
        if request.form.get("accion") == "realizar_venta":
            tipo = request.form.get("comprobante_tipo")  # "Boleta" o "Factura"
            serie, numero = Venta.generar_comprobante(tipo)

            venta.estado_id = 7
            venta.comprobante_tipo = tipo
            venta.comprobante_serie = serie
            venta.comprobante_numero = numero
            venta.comprobante_fecha = datetime.now()
            venta.comprobante_estado = True
            venta.comprobante_usuario_id = current_user.id

        # — GUARDAR O REACTIVAR PRODUCTOS
        for cp in productos:
            existente = VentaProducto.query.filter_by(
                venta_id=venta.id,
                producto_id=cp.producto_id
            ).first()

            if existente:
                # Reactivar y actualizar
                existente.activo           = True
                existente.descripcion      = cp.descripcion
                existente.cantidad         = cp.cantidad
                existente.precio_unitario  = cp.precio_unitario
                existente.descuento_monto  = cp.descuento_monto
                existente.costo            = cp.costo
            else:
                # Nuevo
                db.session.add(cp)

        # — GUARDAR O REACTIVAR SERVICIOS
        for cs in servicios:
            existente = VentaServicio.query.filter_by(
                venta_id=venta.id,
                servicio_id=cs.servicio_id
            ).first()

            if existente:
                # Reactivar y actualizar
                existente.activo           = True
                existente.descripcion      = cs.descripcion
                existente.cantidad         = cs.cantidad
                existente.precio_unitario  = cs.precio_unitario
                existente.descuento_monto  = cs.descuento_monto
            else:
                # Nuevo
                db.session.add(cs)


        db.session.commit()
        flash("Cotización actualizada correctamente", "success")

    except Exception as e:
        import traceback
        traceback.print_exc()
        db.session.rollback()
        flash(f"Error al actualizar: {e}", "danger")

    return redirect(url_for("cotizacion.listar_cotizaciones"))


@cotizacion_bp.route('/ventas/<int:venta_id>', methods=['GET', 'POST'])
@login_required
def realizar_venta(venta_id):
    venta = Venta.query.get_or_404(venta_id)
    
    # ✅ Validaciones de estado
    if venta.estado.nombre in ["Pagado", "Pagada"]:
        flash("La cotización ya ha sido pagada.", "warning")
        return redirect(url_for('cotizacion.listar_cotizaciones'))

    if venta.estado.nombre in ["Anulado", "Anulada"]:
        flash("La cotización está anulada y no se puede procesar.", "danger")
        return redirect(url_for('cotizacion.listar_cotizaciones'))
    
    if request.method == "POST":
        fecha_str = request.form["comprobante_fecha"]
        fecha_obj = datetime.strptime(fecha_str, "%Y-%m-%d")
        
        venta.estado_id=7
        venta.comprobante_estado = True
        venta.comprobante_tipo = request.form["comprobante_tipo"]
        venta.comprobante_serie = request.form["comprobante_serie"]
        venta.comprobante_numero = int(request.form["comprobante_numero"])
        venta.comprobante_fecha = fecha_obj
        venta.comprobante_usuario_id=current_user.id
        
        db.session.commit()
        flash("Venta realizada con Éxito", "success")
        return redirect(url_for('cotizacion.listar_cotizaciones'))
        