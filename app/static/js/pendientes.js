document.addEventListener('DOMContentLoaded', function() {
  // Nuevo
  document.querySelector('.btn-success[data-bs-target="#modalPendiente"]').onclick = function() {
    limpiarForm();
  };

  // Editar
  document.querySelectorAll('.btn-editar').forEach(btn => {
    btn.onclick = function() {
      const tr = this.closest('tr');
      document.getElementById('pendiente-id').value = tr.dataset.id;
      document.getElementById('pendiente-titulo').value = tr.children[0].textContent;
      document.getElementById('pendiente-descripcion').value = tr.children[1].textContent;
      document.getElementById('pendiente-estado').value = tr.children[2].textContent.trim();
      document.getElementById('pendiente-fecha').value = tr.children[3].textContent.trim();
      new bootstrap.Modal(document.getElementById('modalPendiente')).show();
    };
  });

  // Borrar
  document.querySelectorAll('.btn-borrar').forEach(btn => {
    btn.onclick = function() {
      const tr = this.closest('tr');
      if(confirm('¿Borrar este pendiente?')) {
        fetch(`/pendientes/${tr.dataset.id}/borrar`, {method:'POST'})
        .then(r=>r.json())
        .then(data => { if(data.success) location.reload(); });
      }
    }
  });

  // Guardar (nuevo o editar)
  document.getElementById('form-pendiente').onsubmit = function(e) {
    e.preventDefault();
    const id = document.getElementById('pendiente-id').value;
    const formData = new FormData(this);
    const url = id ? `/pendientes/${id}/editar` : '/pendientes/crear';
    fetch(url, {method:'POST', body:formData})
    .then(r=>r.json())
    .then(data => { if(data.success) location.reload(); });
  };

  function limpiarForm() {
    document.getElementById('pendiente-id').value = '';
    document.getElementById('pendiente-titulo').value = '';
    document.getElementById('pendiente-descripcion').value = '';
    document.getElementById('pendiente-estado').value = 'Pendiente';
    document.getElementById('pendiente-fecha').value = '';
  }
});
