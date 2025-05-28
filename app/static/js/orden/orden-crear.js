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

document.addEventListener('DOMContentLoaded', function () {
  var btnCrearOrden = document.getElementById('btnCrearOrden');
  if (btnCrearOrden) {
    btnCrearOrden.addEventListener('click', function () {
      var modalCreate = new bootstrap.Modal(document.getElementById('modalCreate'));
      modalCreate.show();
    });
  }
});



// Scrips secundarios

// --- create_numero: Generar número de orden automáticamente ---
document.addEventListener('DOMContentLoaded', function() {
  var modalCreate = document.getElementById('modalCreate');
  modalCreate.addEventListener('show.bs.modal', function () {
    // Buscar el mayor número de orden actual en la tabla
    var maxNum = 0;
    var table = document.getElementById('ordenesTable');
    if (table) {
      var rows = table.querySelectorAll('tbody tr');
      rows.forEach(function(row) {
        var numCell = row.querySelector('td:nth-child(2)');
        if (numCell) {
          var match = numCell.textContent.trim().match(/^ORD-(\d+)$/);
          if (match) {
            var num = parseInt(match[1]);
            if (num > maxNum) maxNum = num;
          }
        }
      });
    }
    // Siguiente número
    var nextNum = maxNum + 1;
    document.getElementById('create_numero').value = 'ORD-' + nextNum;
  });
});

// filtracionr clientes por DNI en el modal
document.addEventListener('DOMContentLoaded', function() {
  const buscarDniInput = document.getElementById('buscarDniInput');
  const tablaClientes = document.getElementById('tablaClientes').getElementsByTagName('tbody')[0];

  buscarDniInput.addEventListener('input', function() {
    const filtro = this.value.trim();
    Array.from(tablaClientes.rows).forEach(row => {
      const dni = row.cells[0].textContent.trim();
      row.style.display = dni.includes(filtro) ? '' : 'none';
    });
  });

  // Seleccionar cliente y cerrar modal
  tablaClientes.addEventListener('click', function(e) {
    if (e.target.classList.contains('seleccionar-cliente')) {
      const id = e.target.getAttribute('data-id');
      const nombre = e.target.getAttribute('data-nombre');
      document.getElementById('cliente_id').value = id;
      document.getElementById('cliente_nombre').value = nombre;
      // Cerrar modal
      var modal = bootstrap.Modal.getInstance(document.getElementById('modalBuscarCliente'));
      modal.hide();
    }
  });
});
// Filtrar usuarios por ID o correo en el modal
document.addEventListener('DOMContentLoaded', function() {
  const buscarUsuarioInput = document.getElementById('buscarUsuarioInput');
  const tablaUsuario = document.getElementById('tablaUsuario').getElementsByTagName('tbody')[0];

  buscarUsuarioInput.addEventListener('input', function() {
    const filtro = this.value.trim().toLowerCase();
    Array.from(tablaUsuario.rows).forEach(row => {
      const id = row.cells[0].textContent.trim();
      const correo = row.cells[1].textContent.trim().toLowerCase();
      row.style.display = (id.includes(filtro) || correo.includes(filtro)) ? '' : 'none';
    });
  });

  // Seleccionar usuario y cerrar modal
  tablaUsuario.addEventListener('click', function(e) {
    if (e.target.classList.contains('seleccionar-usuario')) {
      const id = e.target.getAttribute('data-id');
      const nombre = e.target.getAttribute('data-nombre');
      document.getElementById('usuario_id').value = id;
      document.getElementById('usuario_nombre').value = nombre;
      // Cerrar modal
      var modal = bootstrap.Modal.getInstance(document.getElementById('modalBuscarUsuario'));
      modal.hide();
    }
  });
});


  // Filtrar vehículos por placa, marca o modelo en el modal
document.addEventListener('DOMContentLoaded', function() {
  const buscarVehiculoInput = document.getElementById('buscarVehiculoInput');
  const tablaAutomoviles = document.getElementById('tablaAutomoviles').getElementsByTagName('tbody')[0];

  buscarVehiculoInput.addEventListener('input', function() {
    const filtro = this.value.trim().toLowerCase();
    Array.from(tablaAutomoviles.rows).forEach(row => {
      const placa = row.cells[1].textContent.trim().toLowerCase();
      const marca = row.cells[2].textContent.trim().toLowerCase();
      const modelo = row.cells[3].textContent.trim().toLowerCase();
      row.style.display =
        placa.includes(filtro) ||
        marca.includes(filtro) ||
        modelo.includes(filtro)
        ? '' : 'none';
    });
  });
});

function validarOrden() {
  const clienteId = document.getElementById('cliente_id').value.trim();
  const usuarioId = document.getElementById('usuario_id').value.trim();
  const automovilId = document.getElementById('automovil_id').value.trim();

  if (!clienteId) {
    alert('Debe seleccionar un cliente.');
    return false;
  }
  if (!usuarioId) {
    alert('Debe seleccionar un usuario.');
    return false;
  }
  if (!automovilId) {
    alert('Debe seleccionar al menos un vehículo.');
    return false;
  }
  return true;
}

document.addEventListener('DOMContentLoaded', function() {
  const tablaAutomoviles = document.getElementById('tablaAutomoviles');
  const inputAutomovilId = document.getElementById('automovil_id');
  const automovilSeleccionado = document.getElementById('automovil_seleccionado');
  const confirmarBtn = document.getElementById('confirmarAutomovil');

  function actualizarPlacasSeleccionadas() {
    const checks = tablaAutomoviles.querySelectorAll('.check-automovil:checked');
    const ids = [];
    const nombres = [];
    checks.forEach(chk => {
      ids.push(chk.value);
      const placa = chk.getAttribute('data-placa');
      const marca = chk.getAttribute('data-marca');
      const modelo = chk.getAttribute('data-modelo');
      nombres.push(`${placa} - ${marca} ${modelo}`);
    });
    inputAutomovilId.value = ids.join(',');
    if (automovilSeleccionado) {
      automovilSeleccionado.textContent = nombres.length > 0
        ? 'Seleccionado: ' + nombres.join(' | ')
        : '';
    }
  }

  if (confirmarBtn) {
    confirmarBtn.addEventListener('click', function() {
      actualizarPlacasSeleccionadas();
      var modal = bootstrap.Modal.getInstance(document.getElementById('modalSeleccionarAutomovil'));
      modal.hide();
    });
  }

  // También actualiza al abrir el modal, por si hay selección previa
  document.getElementById('modalSeleccionarAutomovil').addEventListener('show.bs.modal', function() {
    actualizarPlacasSeleccionadas();
  });
});

  // Al confirmar selección de vehículos envio a formulario servicio
document.getElementById('confirmarAutomovill').addEventListener('click', function() {
  const checks = document.querySelectorAll('.check-automovil:checked');
  window.vehiculosSeleccionados = [];
  checks.forEach(chk => {
    window.vehiculosSeleccionados.push({
      id: chk.value,
      placa: chk.getAttribute('data-placa'),
      modelo: chk.getAttribute('data-modelo'),
      marca: chk.getAttribute('data-marca')
    });
  });

});

  //Rellenar tabla
  document.addEventListener('DOMContentLoaded', function() {
  const modalServiciosPorVehiculo = document.getElementById('modalServiciosPorVehiculo');
  const tablaVehiculosServicios = document.getElementById('tablaVehiculosServicios').getElementsByTagName('tbody')[0];

  modalServiciosPorVehiculo.addEventListener('show.bs.modal', function() {
    tablaVehiculosServicios.innerHTML = '';
    if (window.vehiculosSeleccionados && window.vehiculosSeleccionados.length > 0) {
      window.vehiculosSeleccionados.forEach(vehiculo => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${vehiculo.placa} - ${vehiculo.modelo}</td>
          <td>
            <button type="button" class="btn btn-sm btn-success seleccionar-servicios-vehiculo" data-id="${vehiculo.id}">
              Seleccionar servicios
            </button>
          </td>
        `;
        tablaVehiculosServicios.appendChild(tr);
      });
    } else {
      tablaVehiculosServicios.innerHTML = `<tr><td colspan="2" class="text-center">No hay vehículos seleccionados.</td></tr>`;
    }
  });

  // Aquí puedes agregar el evento para abrir el siguiente modal al hacer click en "Seleccionar servicios"
  tablaVehiculosServicios.addEventListener('click', function(e) {
    if (e.target.classList.contains('seleccionar-servicios-vehiculo')) {
      const vehiculoId = e.target.getAttribute('data-id');
      // Aquí llamas a la función para abrir el modal de servicios para ese vehículo
      // abrirModalServiciosPorVehiculo(vehiculoId);
    }
  });
});


  //input de servicio
  document.addEventListener('DOMContentLoaded', function() {
  const inputServicioId = document.getElementById('servicio_id');
  const serviciosSeleccionadosDiv = document.getElementById('servicios_seleccionados');
  const confirmarBtn = document.getElementById('confirmarServicios');
  const tablaServicios = document.getElementById('tablaServicios');

  function actualizarServiciosSeleccionados() {
    const checks = tablaServicios.querySelectorAll('.check-servicio:checked');
    const ids = [];
    const resumen = [];
    checks.forEach(chk => {
      const id = chk.value;
      const nombre = chk.getAttribute('data-nombre');
      const precio = chk.getAttribute('data-precio');
      ids.push(id);
      resumen.push(`${nombre} ($${precio})`);
    });
    inputServicioId.value = ids.join(',');
    serviciosSeleccionadosDiv.textContent = resumen.length > 0
      ? 'Seleccionado: ' + resumen.join(' | ')
      : '';
  }

  if (confirmarBtn) {
    confirmarBtn.addEventListener('click', function() {
      actualizarServiciosSeleccionados();
      var modal = bootstrap.Modal.getInstance(document.getElementById('modalSeleccionarServicios'));
      modal.hide();
    });
  }
});


  // --- Calcular total automáticamente ---
document.addEventListener('DOMContentLoaded', function() {
  const tablaServicios = document.getElementById('tablaServicios');
  const descuentoSelect = document.getElementById('create_descuento');
  const totalInput = document.getElementById('total');

  function calcularTotal() {
    // Sumar precios de servicios seleccionados
    let suma = 0;
    if (tablaServicios) {
      const checks = tablaServicios.querySelectorAll('.check-servicio:checked');
      checks.forEach(chk => {
        const precio = parseFloat(chk.getAttribute('data-precio')) || 0;
        suma += precio;
      });
    }
    // Obtener descuento
    const descuento = parseFloat(descuentoSelect.value) || 0;
    // Aplicar descuento
    const total = suma - (suma * descuento / 100);
    totalInput.value = total.toFixed(2);
  }

  // Actualizar total al seleccionar/deseleccionar servicios
  if (tablaServicios) {
    tablaServicios.addEventListener('change', function(e) {
      if (e.target.classList.contains('check-servicio')) {
        calcularTotal();
      }
    });
  }

  // Actualizar total al cambiar descuento
  if (descuentoSelect) {
    descuentoSelect.addEventListener('change', calcularTotal);
  }

  // Al confirmar selección de servicios, recalcula
  const confirmarServiciosBtn = document.getElementById('confirmarServicios');
  if (confirmarServiciosBtn) {
    confirmarServiciosBtn.addEventListener('click', calcularTotal);
  }

  // Inicializa el total al cargar
  calcularTotal();
});