from flask import Blueprint, render_template, request
from flask_login import login_required, current_user
from app.extensions import db

# IMPORTA AQUÍ TU MODELO DE COMPROBANTES:
from app.models.comprobante import Comprobante

receipts_bp = Blueprint("receipts", __name__, url_prefix="/comprobantes")

@receipts_bp.route("/", methods=["GET"])
@login_required
def list_receipts():
    page = request.args.get("page", 1, type=int)
    per_page = 10

    pagination = (
        Comprobante.query
                   .order_by(Comprobante.id.desc())
                   .paginate(page=page, per_page=per_page, error_out=False)
    )
    return render_template(
        "receipts/list.html",
        receipts=pagination.items,
        pagination=pagination
    )
