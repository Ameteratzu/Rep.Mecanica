window.camposProducto = window.camposProducto || {};

function cargarProductos() {
    const input = document.getElementById("buscarProductoInput").value.toLowerCase();

    fetch(`/productos/buscar_productos?term=${encodeURIComponent(input)}`)
        .then(response => response.json())
        .then(data => {
            const tabla = document.querySelector("#modalProducto tbody");
            tabla.innerHTML = "";

            if (!Array.isArray(data) || data.length === 0) {
                tabla.innerHTML = "<tr><td colspan='8' class='text-center'>No se encontraron productos</td></tr>";
                return;
            }

            data.forEach(producto => {
                const fila = `
                    <tr>
                        <td>${producto.codigo}</td>
                        <td>${producto.nombre}</td>
                        <td>${producto.marca}</td>
                        <td>${producto.categoria}</td>
                        <td>${producto.stock}</td>
                        <td>${producto.costo.toFixed(2)}</td>
                        <td>${producto.precio.toFixed(2)}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary seleccionar-producto"
                                data-id="${producto.id}"
                                data-codigo="${producto.codigo}"
                                data-nombre="${producto.nombre.replace(/'/g, "\\'")}"
                                data-marca="${producto.marca}"
                                data-categoria="${producto.categoria}"
                                data-stock="${producto.stock}"
                                data-costo="${producto.costo}"
                                data-precio="${producto.precio}">
                                Seleccionar
                            </button>
                        </td>
                    </tr>`;
                tabla.innerHTML += fila;
            });
        })
        .catch(error => {
            console.error("Error al cargar productos:", error);
            const tabla = document.getElementById("tablaProductos");
            tabla.innerHTML = "<tr><td colspan='8' class='text-danger text-center'>Error al conectar con el servidor</td></tr>";
        });
}

document.addEventListener('DOMContentLoaded', function () {
    document.addEventListener('click', function (event) {
        const btn = event.target.closest('.abrir-modal-secundario');
        if (btn && btn.dataset.modalDestino === "modalProducto") {
            camposProducto = {
                modalOrigen: btn.dataset.modalOrigen || ''
            };
            const modalProducto = bootstrap.Modal.getOrCreateInstance(document.getElementById('modalProducto'));
            modalProducto.show();
            cargarProductos();
        }
    });

    document.addEventListener('shown.bs.modal', function (event) {
        if (event.target.id === 'modalProducto') {
            const input = document.querySelector("#buscarProductoInput");
            input?.focus();
            input?.addEventListener("input", cargarProductos);
        }
    });

    document.querySelector("#modalProducto").addEventListener("click", function (e) {
        const btn = e.target.closest(".seleccionar-producto");
        if (btn) {
            const producto = {
                id: btn.dataset.id,
                codigo: btn.dataset.codigo,
                nombre: btn.dataset.nombre,
                marca: btn.dataset.marca,
                categoria: btn.dataset.categoria,
                stock: parseInt(btn.dataset.stock),
                costo: parseFloat(btn.dataset.costo),
                precio: parseFloat(btn.dataset.precio)
            };

            if (typeof window.seleccionarProducto === "function") {
                window.seleccionarProducto(producto);  // Pasamos todo el objeto
            } else {
                console.warn("Función seleccionarProducto no definida en este contexto");
            }

            const modal = bootstrap.Modal.getInstance(document.getElementById('modalProducto'));
            if (modal) modal.hide();
        }
    });
});
