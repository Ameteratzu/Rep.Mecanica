let rolActual = null;

// Selección de rol: carga permisos vía AJAX y muestra el panel
document.querySelectorAll('.rol-btn').forEach(btn => {
  btn.addEventListener('click', function() {
    rolActual = this.getAttribute('data-id');
    document.getElementById('nombre-rol').innerText = this.innerText;
    // desmarca todos
    document.querySelectorAll('.permiso-check').forEach(chk => chk.checked = false);
    fetch('/roles/permisos/data?rol_id=' + rolActual)
      .then(r => r.json())
      .then(data => {
        data.permisos.forEach(pid => {
          let chk = document.querySelector('.permiso-check[data-id="'+pid+'"]');
          if(chk) chk.checked = true;
        });
        document.getElementById('permisos-panel').style.display = '';
      });
  });
});

// Botón seleccionar todo
document.getElementById('select-all').onclick = () => {
  document.querySelectorAll('.permiso-check').forEach(chk => chk.checked = true);
};
// Botón quitar todo
document.getElementById('deselect-all').onclick = () => {
  document.querySelectorAll('.permiso-check').forEach(chk => chk.checked = false);
};

// Guardar permisos vía AJAX
document.getElementById('form-permisos').addEventListener('submit', function(e){
  e.preventDefault();
  if(!rolActual) return;
  let permisos = [];
  document.querySelectorAll('.permiso-check:checked').forEach(chk => {
    permisos.push(parseInt(chk.getAttribute('data-id')));
  });
  fetch('/roles/permisos/update', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({rol_id: rolActual, permisos: permisos})
  })
  .then(r => r.json())
  .then(data => {
    if(data.success) alert('¡Permisos guardados!');
    else alert('Error al guardar');
  });
});
