// FECHA AUTOMÁTICA EN CAMPOS
// =============================
document.addEventListener("DOMContentLoaded", function () {
  const hoy = new Date();
  const yyyy = hoy.getFullYear();
  const mm = String(hoy.getMonth() + 1).padStart(2, '0');
  const dd = String(hoy.getDate()).padStart(2, '0');
  const fechaActual = `${yyyy}-${mm}-${dd}`;

  document.querySelectorAll(".fecha-hoy").forEach(input => {
    input.value = fechaActual;
  });
});