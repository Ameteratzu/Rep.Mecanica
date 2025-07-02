document.querySelectorAll('.btn-guardar').forEach(btn => {
  btn.addEventListener('click', function() {
    const usuarioId = this.getAttribute('data-usuario');
    const select = document.querySelector('.select-rol[data-usuario="' + usuarioId + '"]');
    const nuevoRol = select.value;

    fetch('/roles/actualizar', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ usuario_id: usuarioId, rol_id: nuevoRol })
    })
    .then(resp => resp.json())
    .then(data => {
      if (data.success) {
        alert("Rol actualizado correctamente");
        window.location.reload();
      } else {
        alert("Error: " + (data.message || 'No se pudo actualizar'));
      }
    });
  });
});
