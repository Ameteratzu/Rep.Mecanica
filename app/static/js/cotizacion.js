// ============================
// VARIABLES GLOBALES
// ============================
window.contadorProductos = window.contadorProductos || 0;
window.contadorServicios = window.contadorServicios || 0;

window.camposProducto = window.camposProducto || {};
window.camposServicio = window.camposServicio || {};

// ============================
// FUNCIONES PARA PRODUCTOS
// ============================

// Limpiar campos de producto
function limpiarCamposProducto() {
  ["codigoProducto", "nombreProducto", "cantidadProducto", "precioProducto"].forEach(id => {
    const campo = document.getElementById(id);
    if (campo) campo.value = "";
  });
}
function limpiarCamposServicio(prefijo = "") {
  const campos = ["codigoServicio", "nombreServicio", "cantidadServicio", "precioServicio", "descuentoServicio"];
  campos.forEach(id => {
    const campo = document.getElementById(prefijo + id);
    if (campo) campo.value = "";
  });
}


// Seleccionar producto desde submodal
window.seleccionarProducto = function (producto) {
  const origen = camposProducto.modalOrigen;

  // Prefijo según el origen
  const prefijo = origen === "editarCotizacionModal" ? "editar_" : "";

  // Asignar valores a los campos
  document.getElementById(prefijo + "codigoProducto").value = producto.codigo;
  document.getElementById(prefijo + "nombreProducto").value = producto.nombre;
  document.getElementById(prefijo + "precioProducto").value = producto.precio.toFixed(2);
  document.getElementById(prefijo + "descuentoProducto").value = 0;
  document.getElementById(prefijo + "cantidadProducto").value = 1;

  // Guardar info del producto seleccionado
  camposProducto.costo = producto.costo;
  camposProducto.id = producto.id;

  // Cierra el modal
  const modal = bootstrap.Modal.getInstance(document.getElementById("modalProducto"));
  if (modal) modal.hide();
};

window.seleccionarServicio = function(servicio) {
  const origen = camposServicio.modalOrigen || "";  // usa "" por defecto si no se define
  const prefijo = origen === "editarCotizacionModal" ? "editar_" : "";
  
  document.getElementById(prefijo + "codigoServicio").value = servicio.codigo;
  document.getElementById(prefijo + "nombreServicio").value = servicio.nombre;  
  document.getElementById(prefijo + "precioServicio").value = servicio.precio.toFixed(2);
  document.getElementById(prefijo + "descuentoServicio").value = servicio.descuento?.toFixed(2) || 0;

  camposServicio.id = servicio.id;
  camposServicio.descripcion = servicio.descripcion;

  console.log("Servicio seleccionado:", servicio);

  const modal = bootstrap.Modal.getInstance(document.getElementById("modalServicio"));
  if (modal) modal.hide();
};


function agregarProducto() {
  const origen = camposProducto.modalOrigen || "";
  const prefijo = origen === "editarCotizacionModal" ? "editar_" : "";

  const codigo = document.getElementById(prefijo + "codigoProducto").value;
  const nombre = document.getElementById(prefijo + "nombreProducto").value;
  const cantidad = parseFloat(document.getElementById(prefijo + "cantidadProducto").value);
  const precio = parseFloat(document.getElementById(prefijo + "precioProducto").value);
  const descuento = parseFloat(document.getElementById(prefijo + "descuentoProducto").value) || 0;

  if (!codigo || !nombre || isNaN(cantidad) || isNaN(precio) || cantidad <= 0 || precio < 0) {
    alert("Por favor completa todos los campos de producto correctamente.");
    return;
  }

  const precioConDescuento = precio - (precio * descuento / 100);
  const total = cantidad * precioConDescuento;
  const idFila = `productoCotizado_${++window.contadorProductos}`;

  const fila = `
    <tr id="${idFila}">
      <input type="hidden" name="productos[${window.contadorProductos}][id]" value="${camposProducto.id}">
      <input type="hidden" name="productos[${window.contadorProductos}][codigo]" value="${codigo}">
      <input type="hidden" name="productos[${window.contadorProductos}][nombre]" value="${nombre}">
      <input type="hidden" name="productos[${window.contadorProductos}][precio]" value="${precio.toFixed(2)}">
      <input type="hidden" name="productos[${window.contadorProductos}][descuento]" value="${descuento}">
      <input type="hidden" name="productos[${window.contadorProductos}][cantidad]" value="${cantidad}">
      <input type="hidden" name="productos[${window.contadorProductos}][costo]" value="${camposProducto.costo}">

      <td>${codigo}</td>
      <td>${nombre}</td>
      <td>${precio.toFixed(2)}</td>
      <td>${descuento}%</td>
      <td>${cantidad}</td>
      <td>${total.toFixed(2)}</td>
      <td>
        <button type="button" class="btn btn-sm btn-danger" onclick="eliminarFila('${idFila}')">Eliminar</button>
      </td>
    </tr>
  `;

  const tabla = document.getElementById(origen === "editarCotizacionModal" ? "editar_productosAgregados" : "productosAgregados");
  tabla.insertAdjacentHTML("beforeend", fila);

  actualizarTotalGeneral(prefijo);
  limpiarCamposProducto(prefijo);
}


// ============================
// FUNCIONES PARA SERVICIOS
// ============================

// Agregar Servicio
function agregarServicio() {
  const origen = camposServicio.modalOrigen || "";
  const prefijo = origen === "editarCotizacionModal" ? "editar_" : "";

  const codigo = document.getElementById(prefijo + "codigoServicio").value;
  const nombre = document.getElementById(prefijo + "nombreServicio").value;
  const cantidad = parseFloat(document.getElementById(prefijo + "cantidadServicio").value);
  const precio = parseFloat(document.getElementById(prefijo + "precioServicio").value);
  const descuento = parseFloat(document.getElementById(prefijo + "descuentoServicio").value);
  const id = camposServicio.id;

  if (!nombre || isNaN(cantidad) || isNaN(precio) || cantidad <= 0 || precio <= 0) {
    alert("Por favor completa correctamente los campos de servicio.");
    return;
  }

  const precioConDescuento = precio - (precio * descuento / 100);
  const total = precioConDescuento * cantidad;
  const idFila = `servicioCotizado_${++window.contadorServicios}`;

  const fila = `
    <tr id="${idFila}">
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][id]" value="${id}">
        <input type="hidden" name="servicios[${window.contadorServicios}][codigo]" value="${codigo}">
        ${codigo}
      </td>
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][nombre]" value="${nombre}">
        ${nombre}
      </td>
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][precio]" value="${precio.toFixed(2)}">
        ${precio.toFixed(2)}
      </td>
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][descuento]" value="${descuento.toFixed(2)}">
        ${descuento.toFixed(2)}%
      </td>
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][cantidad]" value="${cantidad}">
        ${cantidad}
      </td>
      <td>
        <input type="hidden" name="servicios[${window.contadorServicios}][total]" value="${total.toFixed(2)}">
        ${total.toFixed(2)}
      </td>
      <td>
        <button type="button" class="btn btn-sm btn-danger" onclick="eliminarFila('${idFila}')">Eliminar</button>
      </td>
    </tr>
  `;

  const tabla = document.getElementById(origen === "editarCotizacionModal" ? "editar_serviciosAgregados" : "serviciosAgregados");
  tabla.insertAdjacentHTML("beforeend", fila);
  actualizarTotalGeneral(prefijo);
  limpiarCamposServicio(prefijo);
}



// ============================
// FUNCIONES GENERALES
// ============================

function eliminarFila(idFila) {
  const fila = document.getElementById(idFila);
  if (!fila) return;

  // 1. Averiguamos en qué tabla está la fila (productos o servicios)
  const tbody = fila.closest("tbody");
  if (!tbody) {
    fila.remove();
    return;
  }

  // 2. Derivamos el prefijo a partir del ID del tbody:
  //    - "productosAgregados"       → prefijo = ""
  //    - "editar_productosAgregados"→ prefijo = "editar_"
  //    - "duplicar_productosAgregados"→ prefijo = "duplicar_"
  let prefijo = "";
  const tableId = tbody.id; // e.g. "editar_productosAgregados"
  if (tableId.endsWith("productosAgregados")) {
    prefijo = tableId.replace("productosAgregados", "");
  } else if (tableId.endsWith("serviciosAgregados")) {
    prefijo = tableId.replace("serviciosAgregados", "");
  }

  // 3. Eliminamos la fila del DOM
  fila.remove();

  // 4. Recalculamos totales con el prefijo correcto
  actualizarTotalGeneral(prefijo);
}


// Calcular total de productos y servicios
function actualizarTotalGeneral(prefijo = "") {
  let totalProductos = 0;
  let totalServicios = 0;

  // Calcular total productos
  document.querySelectorAll(`#${prefijo}productosAgregados tr`).forEach(tr => {
    const precio = parseFloat(tr.querySelector('input[name$="[precio]"]')?.value || 0);
    const cantidad = parseFloat(tr.querySelector('input[name$="[cantidad]"]')?.value || 0);
    const descuento = parseFloat(tr.querySelector('input[name$="[descuento]"]')?.value || 0);
    const precioFinal = precio - (precio * descuento / 100);
    const subtotal = precioFinal * cantidad;
    totalProductos += subtotal;
  });

  // Calcular total servicios
  document.querySelectorAll(`#${prefijo}serviciosAgregados tr`).forEach(tr => {
    const total = parseFloat(tr.querySelector('input[name$="[total]"]')?.value || 0);
    totalServicios += total;
  });

  const subtotal = totalProductos + totalServicios;

  // Descuento global (%)
  const descuentoInput = document.getElementById(`${prefijo}descuento_porcentaje`) || document.getElementById("descuento");
  const descuento = parseFloat(descuentoInput?.value || 0);
  const descuento_monto = isNaN(descuento) ? 0 : subtotal * descuento / 100;

  const totalSinIGV = subtotal - descuento_monto;
  const igv = totalSinIGV * 0.18;
  const totalGeneral = totalSinIGV + igv;

  // Mostrar en los inputs
  const setValor = (id, valor) => {
    const campo = document.getElementById(`${prefijo}${id}`);
    if (campo) campo.value = valor.toFixed(2);
  };

  setValor("totalProductos", totalProductos);
  setValor("totalServicios", totalServicios);
  setValor("subtotal", subtotal);
  setValor("descuento_monto", descuento_monto);
  setValor("total_sin_igv", totalSinIGV);
  setValor("igv", igv);
  setValor(prefijo === "editar_" ? "total" : "totalCotizacion", totalGeneral);
}




// ============================
// INICIALIZACIÓN DE EVENTOS
// ============================

// Esto escucha clicks en cualquier momento del DOM, incluso si se cargan dinámicamente
document.addEventListener("click", function (e) {
  const target = e.target;
  if (!target) return;

  // Botón agregar producto
  if (target.id === "btnAgregarProducto" || target.id === "editar_btnAgregarProducto") {
    agregarProducto();
  }

  // Botón agregar servicio
  if (target.id === "btnAgregarServicio" || target.id === "editar_btnAgregarServicio") {
    agregarServicio();
  }

  // Si usas botones dinámicos adicionales, puedes seguir agregando aquí
});

document.addEventListener("input", function (e) {
  const target = e.target;
  if (!target) return;

  // Reacciona al cambio del campo de descuento global
  switch (target.id) {
    case "descuento":
      actualizarTotalGeneral(""); // Modal nuevo
      break;
    case "editar_descuento_porcentaje":
      actualizarTotalGeneral("editar_"); // Modal editar
      break;
    case "duplicar_descuento_porcentaje":
      actualizarTotalGeneral("duplicar_"); // Si haces otro modal
      break;
  }
});
