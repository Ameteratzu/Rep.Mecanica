function openEditModal(id, numero, cliente_id, usuario_id, automovil_id, total, estado_orden_id, estado) {
  // Rellenar los campos del modal
  document.getElementById('edit_id').value = id;
  document.getElementById('edit_numero').value = numero;
  document.getElementById('edit_cliente_id').value = cliente_id;
  document.getElementById('edit_usuario_id').value = usuario_id;
  document.getElementById('edit_automovil_id').value = automovil_id;
  document.getElementById('edit_total').value = total;
  document.getElementById('edit_estado_orden_id').value = estado_orden_id;
  document.getElementById('edit_estado').value = estado;
  document.getElementById('editForm').action = "/orden/update/" + id;
  // Mostrar el modal Bootstrap
  var modal = new bootstrap.Modal(document.getElementById('modalEdit'));
  modal.show();
}
