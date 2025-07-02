// cotizacion_editar.js
let productosEditados = [];
let serviciosEditados = [];

function setValor(prefijo, campo, valor) {
  const input = document.getElementById(prefijo + campo);
  if (input) input.value = valor;
}

document.addEventListener("DOMContentLoaded", () => {
  const botonesEditar = document.querySelectorAll(".btnEditarCotizacion");

  botonesEditar.forEach(button => {
    button.addEventListener("click", async () => {
      const id = button.getAttribute("data-id");
      const prefijo = "editar_";

      try {
        const response = await fetch(`/cotizaciones/obtener/${id}`);
        const data = await response.json();

        setValor(prefijo, "venta_id", data.id);
        document.getElementById("formEditarCotizacion").action = `/cotizaciones/editar/${data.id}`;

        setValor(prefijo, "codigo", data.codigo);
        setValor(prefijo, "fecha", data.fecha);
        setValor(prefijo, "fecha_vencimiento", data.fecha_vencimiento);
        setValor(prefijo, "estado_id", data.estado_id);

        setValor(prefijo, "cliente_id", data.cliente.id);
        setValor(prefijo, "dni", data.cliente.documento);
        setValor(prefijo, "nombre_cliente", data.cliente.nombre);
        setValor(prefijo, "celular", data.cliente.celular);

        setValor(prefijo, "automovil_id", data.automovil.id);
        setValor(prefijo, "placa_auto", data.automovil.placa);
        setValor(prefijo, "detalle_auto", data.automovil.detalle);

        setValor(prefijo, "diagnostico", data.diagnostico);
        setValor(prefijo, "observaciones", data.observaciones);
        setValor(prefijo, "descuento_porcentaje", data.descuento_porcentaje);
        setValor(prefijo, "subtotal", data.subtotal);
        setValor(prefijo, "descuento_monto", data.descuento_monto);
        setValor(prefijo, "total_sin_igv", data.total_sin_igv);
        setValor(prefijo, "igv", data.igv);
        setValor(prefijo, "total", data.total);

        console.log("Respuesta JSON completa:", data);

        renderizarProductosYServiciosEditados(data.productos, data.servicios, prefijo);
        calcularTotalEditado(prefijo);

        const modalEl = document.getElementById('editarCotizacionModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

      } catch (error) {
        console.error("Error al cargar cotización:", error);
      }
    });
  });
});

function renderizarProductosYServiciosEditados(productos, servicios, prefijo) {
  productosEditados = productos;
  serviciosEditados = servicios;

  const tbodyProductos = document.getElementById(prefijo + "productosAgregados");
  const tbodyServicios = document.getElementById(prefijo + "serviciosAgregados");

  tbodyProductos.innerHTML = "";
  tbodyServicios.innerHTML = "";

  let totalProductos = 0;
  let totalServicios = 0;

  productos.forEach((prod, i) => {
    const subtotal = prod.subtotal.toFixed(2);
    const fila = `
      <tr>
        <td>
          <input type="hidden" name="productos[${i}][id]" value="${prod.id}">
          <input type="hidden" name="productos[${i}][codigo]" value="${prod.codigo}">
          ${prod.codigo}
        </td>
        <td>
          <input type="hidden" name="productos[${i}][nombre]" value="${prod.nombre}">
          ${prod.nombre}
        </td>
        <td>
          <input type="hidden" name="productos[${i}][precio]" value="${prod.precio.toFixed(2)}">
          S/ ${prod.precio.toFixed(2)}
        </td>
        <td>
          <input type="hidden" name="productos[${i}][descuento]" value="${prod.descuento_porcentaje}">
          ${prod.descuento_porcentaje}%
        </td>
        <td>
          <input type="hidden" name="productos[${i}][cantidad]" value="${prod.cantidad}">
          ${prod.cantidad}
        </td>
        <td>
          <input type="hidden" name="productos[${i}][subtotal]" value="${subtotal}">
          S/ ${subtotal}
        </td>
        <td>
          <button type="button" class="btn btn-danger btn-sm eliminar-producto" data-index="${i}">X</button>
        </td>
      </tr>
    `;
    tbodyProductos.insertAdjacentHTML("beforeend", fila);
    totalProductos += parseFloat(subtotal);
  });

  servicios.forEach((serv, i) => {
    const total = serv.subtotal.toFixed(2);
    const fila = `
      <tr>
        <td>
          <input type="hidden" name="servicios[${i}][id]" value="${serv.id}">
          <input type="hidden" name="servicios[${i}][codigo]" value="${serv.codigo}">
          ${serv.codigo}
        </td>
        <td>
          <input type="hidden" name="servicios[${i}][nombre]" value="${serv.nombre}">
          ${serv.nombre}
        </td>
        <td>
          <input type="hidden" name="servicios[${i}][precio]" value="${serv.precio.toFixed(2)}">
          S/ ${serv.precio.toFixed(2)}
        </td>
        <td>
          <input type="hidden" name="servicios[${i}][descuento]" value="${serv.descuento_porcentaje}">
          ${serv.descuento_porcentaje}%
        </td>
        <td>
          <input type="hidden" name="servicios[${i}][cantidad]" value="${serv.cantidad}">
          ${serv.cantidad}
        </td>
        <td>
          <input type="hidden" name="servicios[${i}][total]" value="${total}">
          S/ ${total}
        </td>
        <td>
          <button type="button" class="btn btn-danger btn-sm eliminar-servicio" data-index="${i}">X</button>
        </td>
      </tr>
    `;
    tbodyServicios.insertAdjacentHTML("beforeend", fila);
    totalServicios += parseFloat(total);
  });

  setValor(prefijo, "totalProductos", totalProductos.toFixed(2));
  setValor(prefijo, "totalServicios", totalServicios.toFixed(2));
}

document.getElementById("editar_descuento_porcentaje").addEventListener("input", () => calcularTotalEditado("editar_"));

function calcularTotalEditado(prefijo) {
  let totalProductos = 0;
  let totalServicios = 0;

  document.querySelectorAll('#productosServiciosEditar input[name$="[subtotal]"]').forEach(input => {
    totalProductos += parseFloat(input.value) || 0;
  });

  document.querySelectorAll('#productosServiciosEditar input[name$="[total]"]').forEach(input => {
    totalServicios += parseFloat(input.value) || 0;
  });

  const subtotal = totalProductos + totalServicios;
  const descuentoPorcentaje = parseFloat(document.getElementById(prefijo + "descuento_porcentaje").value || 0);
  const descuentoMonto = subtotal * (descuentoPorcentaje / 100);
  const totalSinIgv = subtotal - descuentoMonto;
  const igv = totalSinIgv * 0.18;
  const totalFinal = totalSinIgv + igv;

  setValor(prefijo, "subtotal", subtotal.toFixed(2));
  setValor(prefijo, "descuento_monto", descuentoMonto.toFixed(2));
  setValor(prefijo, "total_sin_igv", totalSinIgv.toFixed(2));
  setValor(prefijo, "igv", igv.toFixed(2));
  setValor(prefijo, "total", totalFinal.toFixed(2));
}

document.getElementById("editar_productosAgregados").addEventListener("click", e => {
  if (e.target.classList.contains("eliminar-producto")) {
    const index = parseInt(e.target.dataset.index);
    productosEditados.splice(index, 1);
    renderizarProductosYServiciosEditados(productosEditados, serviciosEditados, "editar_");
    calcularTotalEditado("editar_");
  }
});

document.getElementById("editar_serviciosAgregados").addEventListener("click", e => {
  if (e.target.classList.contains("eliminar-servicio")) {
    const index = parseInt(e.target.dataset.index);
    serviciosEditados.splice(index, 1);
    renderizarProductosYServiciosEditados(productosEditados, serviciosEditados, "editar_");
    calcularTotalEditado("editar_");
  }
});
