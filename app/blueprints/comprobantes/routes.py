from flask import Blueprint, render_template
from flask_login import login_required
from app.models.comprobante import Comprobante

comprobantes_bp = Blueprint("comprobantes", __name__, url_prefix="/comprobantes")

@comprobantes_bp.route("/", methods=["GET"])
@login_required
def list_comprobantes():
    # Carga los comprobantes desde la base de datos
    items = Comprobante.query.order_by(Comprobante.id.desc()).all()
    return render_template(
        "comprobantes/list.html",
        comprobantes=items,
        active="comprobantes"
    )
