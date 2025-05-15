from flask import Blueprint, render_template, request
from flask_login import login_required
from app.models.cliente import Cliente
from app.extensions import db

cliente_bp = Blueprint(
    "cliente", 
    __name__, 
    url_prefix="/clientes",
    template_folder="templates/clients"
)

@cliente_bp.route("/", methods=["GET"])
@login_required
def list_cliente():
    # Paginación básica
    page = request.args.get("page", 1, type=int)
    pagination = Cliente.query.order_by(Cliente.id.desc()).paginate(
        page=page, per_page=10, error_out=False
    )
    clientes = pagination.items
    return render_template(
        "cliente/list.html",
        clientes=clientes,
        pagination=pagination,
        active="cliente"
    )

@cliente_bp.route('/export', methods=['GET'])
@login_required
def export_excel():
    clientes = Cliente.query.all()
    df = pd.DataFrame([{
      'ID': c.id,
      'Documento': c.documento,
      'Nombre': c.nombres,
      'Apellido': c.apellidos,
      'Celular': c.celular
    } for c in clientes])
    buf = io.BytesIO()
    with pd.ExcelWriter(buf, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Clientes')
    buf.seek(0)
    return send_file(buf,
                     mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                     as_attachment=True,
                     download_name='clientes.xlsx')

