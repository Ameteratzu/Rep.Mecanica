let camposAuto = {};

function cargarAutomoviles() {
    let input = document.getElementById("busquedaAuto").value.toLowerCase();

    fetch(`/automoviles/buscar_automoviles?term=${encodeURIComponent(input)}`)
    .then(response => response.json())
    .then(data => {
        let tabla = document.getElementById("tablaAutos");
        tabla.innerHTML = "";

        if (data.length === 0) {
            tabla.innerHTML = "<tr><td colspan='5' class='text-center'>No se encontraron automóviles</td></tr>";
            return;
        }

        data.forEach(auto => {
            let fila = `
              <tr>
                  <td>${auto.id}</td>
                  <td>${auto.placa}</td>
                  <td>${auto.marca}</td>
                  <td>${auto.modelo}</td>
                  <td>
                      <button type="button" class="btn btn-primary btn-sm"
                        onclick="seleccionarAuto(${auto.id}, '${auto.placa}', '${auto.marca}', '${auto.modelo}')">
                        Seleccionar
                      </button>
                  </td>
              </tr>`;
            tabla.innerHTML += fila;
        });
    });
}

document.addEventListener('DOMContentLoaded', function() {
    document.addEventListener('click', function(event) {
        if (event.target.closest('.btnBuscarAuto')) {
            const btn = event.target.closest('.btnBuscarAuto');
            camposAuto = {
                idField: btn.dataset.autoId,
                placaField: btn.dataset.autoPlaca,
                detalleField: btn.dataset.autoDetalle
            };

            const modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('modal_buscar_auto'));
            modal.show();
            cargarAutomoviles();
        }
    });

    const inputBusqueda = document.getElementById("busquedaAuto");
    inputBusqueda.addEventListener("keyup", cargarAutomoviles);
});

function seleccionarAuto(id, placa, marca, modelo) {
    const idField = document.getElementById(camposAuto.idField);
    const placaField = document.getElementById(camposAuto.placaField);
    const detalleField = document.getElementById(camposAuto.detalleField);

    if (idField) idField.value = id;
    if (placaField) placaField.value = placa;
    if (detalleField) detalleField.value = `${marca} ${modelo}`;

    const modal = bootstrap.Modal.getInstance(document.getElementById('modal_buscar_auto'));
    modal.hide();
}
