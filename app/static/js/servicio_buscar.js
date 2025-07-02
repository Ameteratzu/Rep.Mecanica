window.camposServicio = window.camposServicio || {};

function cargarServicios() {
    const input = document.getElementById("buscarServicioInput").value.toLowerCase();

    fetch(`/servicios/buscar_servicios?term=${encodeURIComponent(input)}`)
        .then(response => response.json())
        .then(data => {
            const tabla = document.querySelector("#modalServicio tbody");
            tabla.innerHTML = "";

            if (!Array.isArray(data) || data.length === 0) {
                tabla.innerHTML = "<tr><td colspan='6' class='text-center'>No se encontraron servicios</td></tr>";
                return;
            }

            data.forEach(servicio => {
                const fila = `
                    <tr>
                        <td>${servicio.codigo || ''}</td>
                        <td>${servicio.nombre || ''}</td>
                        <td>${servicio.descripcion || ''}</td>
                        <td>${parseFloat(servicio.precio || 0).toFixed(2)}</td>
                        <td>${parseFloat(servicio.descuento || 0).toFixed(2)}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary seleccionar-servicio"
                                data-id="${servicio.id}"
                                data-codigo="${servicio.codigo || ''}"
                                data-nombre="${(servicio.nombre || '').replace(/'/g, "\\'")}"
                                data-descripcion="${(servicio.descripcion || '').replace(/'/g, "\\'")}"
                                data-precio="${servicio.precio || 0}"
                                data-descuento="${servicio.descuento || 0}">
                                Seleccionar
                            </button>
                        </td>
                    </tr>`;
                tabla.innerHTML += fila;
            });

        })
        .catch(error => {
            console.error("Error al cargar servicios:", error);
            const tabla = document.getElementById("tablaServicios");
            tabla.innerHTML = "<tr><td colspan='6' class='text-danger text-center'>Error al conectar con el servidor</td></tr>";
        });
}

document.addEventListener('DOMContentLoaded', function () {
    document.addEventListener('click', function (event) {
        const btn = event.target.closest('.abrir-modal-secundario');
        if (btn && btn.dataset.modalDestino === "modalServicio") {
            camposServicio = {
                modalOrigen: btn.dataset.modalOrigen || ''
            };
            const modalServicio = bootstrap.Modal.getOrCreateInstance(document.getElementById('modalServicio'));
            modalServicio.show();
            cargarServicios();
        }
    });

    document.addEventListener('shown.bs.modal', function (event) {
        if (event.target.id === 'modalServicio') {
            const input = document.querySelector("#buscarServicioInput");
            input?.focus();
            input?.addEventListener("input", cargarServicios);
        }
    });

    document.querySelector("#modalServicio").addEventListener("click", function (e) {
        const btn = e.target.closest(".seleccionar-servicio");
        if (btn) {
            const servicio = {
                id: btn.dataset.id,
                codigo: btn.dataset.codigo,
                nombre: btn.dataset.nombre,
                descripcion: btn.dataset.descripcion,
                precio: parseFloat(btn.dataset.precio),
                descuento: parseFloat(btn.dataset.descuento)
            };

            if (typeof window.seleccionarServicio === "function") {
                window.seleccionarServicio(servicio);  // Pasamos todo el objeto
            } else {
                console.warn("Función seleccionarServicio no definida en este contexto");
            }

            const modal = bootstrap.Modal.getInstance(document.getElementById('modalServicio'));
            if (modal) modal.hide();
        }
    });
});
