let contadorProductos = 0;
window.camposProducto = window.camposProducto || {}; // Para la selección desde el modal

// Limpiar campos del formulario de producto
function limpiarCamposProducto() {
  ["codigoProducto", "nombreProducto", "cantidadProducto", "costoProducto"].forEach(id => {
    const campo = document.getElementById(id);
    if (campo) campo.value = "";
  });

  const idOculto = document.getElementById("idProductoSeleccionado");
  if (idOculto) idOculto.value = "";
}
// Seleccionar producto desde el submodal
window.seleccionarProducto = function(producto) {  
  

  document.getElementById("codigoProducto").value = producto.codigo;
  document.getElementById("nombreProducto").value = producto.nombre;
  document.getElementById("cantidadProducto").value = "";
  document.getElementById("costoProducto").value = "";

  camposProducto.id = producto.id;
 


  // ✅ Agrega cierre del modal aquí
  const modal = bootstrap.Modal.getInstance(document.getElementById("modalProducto"));
  if (modal) modal.hide();
};

// Eliminar fila de producto
function eliminarProducto(idFila) {
  const fila = document.getElementById(idFila);
  if (fila) {
    fila.remove();
    actualizarTotalGeneral();
  }
}

// Actualizar total general en la tabla
function actualizarTotalGeneral() {
  let total = 0;
  document.querySelectorAll("#productosAgregados tr").forEach(tr => {
    const totalFila = parseFloat(tr.cells[4]?.innerText || 0);
    total += totalFila;
  });
  document.getElementById("totalGeneral").textContent = total.toFixed(2);
}

// Agregar producto a la tabla
function agregarProducto() {
  const codigo = document.getElementById("codigoProducto").value;
  const nombre = document.getElementById("nombreProducto").value;
  const cantidad = parseFloat(document.getElementById("cantidadProducto").value);
  const costo = parseFloat(document.getElementById("costoProducto").value);

  if (!codigo || !nombre || isNaN(cantidad) || isNaN(costo) || cantidad <= 0 || costo < 0) {
    alert("Por favor completa todos los campos correctamente.");
    return;
  }

  const total = cantidad * costo;
  const idFila = `producto_${++contadorProductos}`;

  const fila = `
    <tr id="${idFila}">
      <td>
        <input type="hidden" name="productos[${contadorProductos}][id]" value="${camposProducto.id}">
        <input type="hidden" name="productos[${contadorProductos}][codigo]" value="${codigo}">${codigo}
      </td>
      <td>
        <input type="hidden" name="productos[${contadorProductos}][nombre]" value="${nombre}">${nombre}
      </td>
      <td>
        <input type="hidden" name="productos[${contadorProductos}][cantidad]" value="${cantidad}">${cantidad}
      </td>
      <td>
        <input type="hidden" name="productos[${contadorProductos}][costo]" value="${costo.toFixed(2)}">${costo.toFixed(2)}
      </td>
      <td>${total.toFixed(2)}</td>
      <td>
        <button type="button" class="btn btn-sm btn-danger" onclick="eliminarProducto('${idFila}')">Eliminar</button>
      </td>
    </tr>
  `;

  document.getElementById("productosAgregados").insertAdjacentHTML("beforeend", fila);
  actualizarTotalGeneral();
  limpiarCamposProducto();
}// Inicializar eventos al cargar el DOM
document.addEventListener('DOMContentLoaded', function () {
  const btnAgregar = document.getElementById("btnAgregarProducto");
  if (btnAgregar) {
    btnAgregar.addEventListener("click", agregarProducto);
  }
})



