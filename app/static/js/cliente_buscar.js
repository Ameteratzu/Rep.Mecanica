let camposCliente = {};  // Aquí guardamos los campos a actualizar

function cargarClientes() {
    let input = document.getElementById("busquedaCliente").value.toLowerCase();

    fetch(`/clientes/buscar_clientes?term=${encodeURIComponent(input)}`)
    .then(response => response.json())
    .then(data => {
        let tabla = document.getElementById("tablaClientes");
        tabla.innerHTML = "";

        if (data.length === 0) {
            tabla.innerHTML = "<tr><td colspan='5' class='text-center'>No se encontraron clientes</td></tr>";
            return;
        }

        data.forEach(cliente => {
            let nombreCompleto = `${cliente.nombres} ${cliente.apellidos}`;
            let fila = `
              <tr>
                  <td>${cliente.id}</td>
                  <td>${cliente.documento}</td>
                  <td>${nombreCompleto}</td>
                  <td>${cliente.celular || ''}</td>
                  <td>
                      <button type="button" class="btn btn-primary btn-sm"
                        onclick="seleccionarCliente(${cliente.id}, '${cliente.nombres.replace(/'/g, "\\'")}', 
                        '${cliente.apellidos.replace(/'/g, "\\'")}', '${cliente.documento}', '${cliente.celular || ''}')">
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
        if (event.target.closest('.btnBuscarCliente')) {
            const btn = event.target.closest('.btnBuscarCliente');

            camposCliente = {
                idField: btn.dataset.clienteId,
                nombreField: btn.dataset.clienteNombre
            };

            const buscarClienteModalEl = document.getElementById('modal_buscar_cliente');
            const buscarClienteModal = bootstrap.Modal.getOrCreateInstance(buscarClienteModalEl);
            buscarClienteModal.show();

            cargarClientes();
        }
    });

    const inputBusqueda = document.getElementById("busquedaCliente");
    inputBusqueda.addEventListener("keyup", function() {
        cargarClientes();
    });
});

function seleccionarCliente(id, nombres, apellidos, documento, celular) {
    if (camposCliente.idField && camposCliente.nombreField) {
        const idField = document.getElementById(camposCliente.idField);
        const nombreField = document.getElementById(camposCliente.nombreField);

        if (idField && nombreField) {
            idField.value = id;
            nombreField.value = `${nombres} ${apellidos}`;
        }
    }

    // Actualizar los campos extra del formulario
    const dniInput = document.getElementById("dni");
    const celularInput = document.getElementById("celular");

    if (dniInput) dniInput.value = documento;
    if (celularInput) celularInput.value = celular;

    const modalBuscarCliente = bootstrap.Modal.getInstance(document.getElementById('modal_buscar_cliente'));
    modalBuscarCliente.hide();
}


