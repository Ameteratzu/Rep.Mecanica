document.addEventListener("click", function (e) {
    if (e.target.classList.contains("seleccionar-proveedor")) {
        const button = e.target;
        const proveedorId = button.dataset.id;
        const ruc = button.dataset.ruc;
        const razonSocial = button.dataset.razon_social;
        const telefono = button.dataset.telefono;
        const direccion = button.dataset.direccion;

        document.getElementById("proveedor_id").value = proveedorId;
        document.getElementById("ruc").value = ruc;
        document.getElementById("razon_social").value = razonSocial;
        document.getElementById("telefono").value = telefono;
        document.getElementById("direccion").value = direccion;

        const modalProveedor = bootstrap.Modal.getInstance(document.getElementById('modalProveedor'));
        modalProveedor.hide();

        const modalIngreso = new bootstrap.Modal(document.getElementById('nuevoIngresoModal'));
        modalIngreso.show();
    }
});
