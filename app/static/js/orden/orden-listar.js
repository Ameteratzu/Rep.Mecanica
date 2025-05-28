// Filtro de fecha para la tabla
document.addEventListener('DOMContentLoaded', function() {
  const filterInput = document.getElementById('filterFecha');
  filterInput.addEventListener('input', function() {
    filterTableByDate(this.value);
  });
});
function filterTableByDate(dateStr) {
  const table = document.getElementById('ordenesTable');
  const rows = table.querySelectorAll('tbody tr');
  rows.forEach(row => {
    const fechaCell = row.querySelector('td:nth-child(3)');
    if (!fechaCell) return;
    const rowDate = fechaCell.textContent.trim();
    if (!dateStr) {
      row.style.display = '';
    } else {
      // rowDate formato: 'YYYY-MM-DD'
      row.style.display = (rowDate === dateStr) ? '' : 'none';
    }
  });
}

// Limpiar filtro fecha
function clearDateFilter() {
  document.getElementById('filterFecha').value = '';
  filterTableByDate('');
}

//Genera archivo ecxel
 function exportToExcel() {
    var table = document.getElementById('ordenesTable');
    var wb = XLSX.utils.table_to_book(table, {sheet:"Sheet 1"});
    XLSX.writeFile(wb, 'mi_archivo.xlsx');
}