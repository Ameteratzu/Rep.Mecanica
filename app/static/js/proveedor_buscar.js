let camposProveedor = {};  // Guardamos los campos donde se asignará el proveedor seleccionado

function cargarProveedores() {
    const input = document.getElementById("filtroProveedor").value.toLowerCase();

    fetch(`/proveedores/buscar_proveedores?term=${encodeURIComponent(input)}`)
        .then(response => response.json())
        .then(data => {
            const tabla = document.getElementById("tablaProveedores").getElementsByTagName("tbody")[0];
            tabla.innerHTML = "";

            if (data.length === 0) {
                tabla.innerHTML = "<tr><td colspan='5' class='text-center'>No se encontraron proveedores</td></tr>";
                return;
            }

            data.forEach(proveedor => {
                let fila = `
                    <tr>
                        <td>${proveedor.ruc}</td>
                        <td>${proveedor.razon_social}</td>
                        <td>${proveedor.telefono}</td>
                        <td>${proveedor.direccion}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary"
                                onclick="seleccionarProveedor(${proveedor.id}, '${proveedor.ruc}', '${proveedor.razon_social.replace(/'/g, "\\'")}', '${proveedor.telefono}', '${proveedor.direccion.replace(/'/g, "\\'")}')">
                                Seleccionar
                            </button>
                        </td>
                    </tr>`;
                tabla.innerHTML += fila;
            });
        });
}

document.addEventListener('DOMContentLoaded', function () {
    // Evento para abrir el modal de proveedor
    document.addEventListener('click', function (event) {
        if (event.target.closest('.btnBuscarProveedor')) {
            const btn = event.target.closest('.btnBuscarProveedor');

            // Campos donde se colocarán los datos seleccionados
            camposProveedor = {
                idField: btn.dataset.proveedorId,
                rucField: btn.dataset.proveedorRuc,
                razonField: btn.dataset.proveedorRazon,
                telefonoField: btn.dataset.proveedorTelefono,
                direccionField: btn.dataset.proveedorDireccion
            };

            const modalProveedor = bootstrap.Modal.getOrCreateInstance(document.getElementById('modalProveedor'));
            modalProveedor.show();

            cargarProveedores();
        }
    });

    // Evento de búsqueda mientras se escribe
    const inputBusqueda = document.getElementById("filtroProveedor");
    inputBusqueda.addEventListener("keyup", function () {
        cargarProveedores();
    });
});

function seleccionarProveedor(id, ruc, razon, telefono, direccion) {
    if (camposProveedor.idField) {
        document.getElementById(camposProveedor.idField).value = id;
        document.getElementById(camposProveedor.rucField).value = ruc;
        document.getElementById(camposProveedor.razonField).value = razon;
        document.getElementById(camposProveedor.telefonoField).value = telefono;
        document.getElementById(camposProveedor.direccionField).value = direccion;
    }

    const modal = bootstrap.Modal.getInstance(document.getElementById('modalProveedor'));
    modal.hide();
}
