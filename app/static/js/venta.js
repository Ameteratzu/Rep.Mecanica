document.addEventListener("DOMContentLoaded", () => {
  const tipoSelect = document.getElementById("comprobante_tipo");
  const serieInput = document.getElementById("comprobante_serie");
  const numeroInput = document.getElementById("comprobante_numero");
  const fechaInput = document.getElementById("comprobante_fecha");
  const datos = document.getElementById("comprobante-datos");

  const valores = {
    Boleta: {
      serie: datos.dataset.boletaSerie,
      numero: datos.dataset.boletaNumero
    },
    Factura: {
      serie: datos.dataset.facturaSerie,
      numero: datos.dataset.facturaNumero
    }
  };

  // Cambia los valores cuando seleccionas tipo de comprobante
  if (tipoSelect) {
    tipoSelect.addEventListener("change", () => {
      const tipo = tipoSelect.value;
      if (valores[tipo]) {
        serieInput.value = valores[tipo].serie;
        numeroInput.value = valores[tipo].numero;
        fechaInput.value = new Date().toISOString().slice(0, 10); // yyyy-mm-dd
      } else {
        serieInput.value = "";
        numeroInput.value = "";
        fechaInput.value = "";
      }
    });
  }

  // ✅✅✅ FUNCIÓN REUTILIZABLE
  async function abrirModalVenta(id) {
    const response = await fetch(`/cotizaciones/obtener/${id}`);
    const data = await response.json();

    console.log("🧾 DATOS MODAL VENTA:", data);

    const modalEl = document.getElementById("nuevaVentaModal");
    const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
    modal.show();

    const form = document.getElementById("formNuevaVenta");
    form.action = `/cotizaciones/ventas/${id}`;
    document.getElementById('venta_id').value = data.id;

    const tipo = "Boleta"; // Valor por defecto
    tipoSelect.value = tipo;
    tipoSelect.dispatchEvent(new Event("change")); // Esto rellena serie/número/fecha

    // Mostrar totales
    document.getElementById("venta_total_productos").textContent = "S/ " + Number(data.total_productos || 0).toFixed(2);
    document.getElementById("venta_total_servicios").textContent = "S/ " + Number(data.total_servicios || 0).toFixed(2);
    document.getElementById("venta_subtotal").textContent = "S/ " + Number(data.subtotal || 0).toFixed(2);
    document.getElementById("venta_descuento_monto").textContent = "S/ " + Number(data.descuento_monto || 0).toFixed(2);
    document.getElementById("venta_total_sin_igv").textContent = "S/ " + Number(data.total_sin_igv || 0).toFixed(2);
    document.getElementById("venta_igv").textContent = "S/ " + Number(data.igv || 0).toFixed(2);
    document.getElementById("venta_total_general").textContent = "S/ " + Number(data.total || 0).toFixed(2);
  }

  // ✅ Manejo del botón "Pagar"
  document.querySelectorAll('.btnPagar').forEach(btn => {
    btn.addEventListener('click', () => {
      const id = btn.dataset.id;
      const estado = btn.dataset.estado;

      if (estado === "Pagado") {
        alert("❌ La cotización ya ha sido pagada.");
        return;
      }else if  (estado === "Anulado" || estado === "Anulada") {
        alert("❌ La cotización está anulada y no se puede pagar.");
        return;
      }else
        abrirModalVenta(id);
    });
  });

  // ✅ Si deseas, puedes exponer la función globalmente para usarla desde otro script:
  window.abrirModalVenta = abrirModalVenta;

});
document.addEventListener("DOMContentLoaded", () => {
  const btnRegistrarYFacturar = document.getElementById("btnRegistrarYFacturar");

  if (btnRegistrarYFacturar) {
    btnRegistrarYFacturar.addEventListener("click", async () => {
      const form = document.querySelector("#nuevaCotizacionModal form");
      const formData = new FormData(form);

      try {
        const response = await fetch(form.action, {
          method: "POST",
          body: formData,
          headers: {
            "X-Requested-With": "XMLHttpRequest"
          }
        });

        const result = await response.json();

        if (result.success && result.venta_id) {
          bootstrap.Modal.getInstance(document.getElementById("nuevaCotizacionModal")).hide();
          abrirModalVenta(result.venta_id);
        } else {
          alert("Error al registrar cotización. Intenta nuevamente.");
        }
      } catch (error) {
        console.error("Error en el envío del formulario:", error);
        alert("Ocurrió un error inesperado.");
      }
    });
  }
});
