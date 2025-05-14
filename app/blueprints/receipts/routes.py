from flask import Blueprint, render_template_string
from flask_login import login_required
from app.models.comprobante import Comprobante

receipts_bp = Blueprint("receipts", __name__, url_prefix="/comprobantes")

@receipts_bp.route("/", methods=["GET"])
@login_required
def list_receipts():
    comprobantes = Comprobante.query.order_by(Comprobante.id.desc()).all()
    return render_template_string("""
    {% extends "base.html" %}
    {% block content %}
      <h1>Comprobantes</h1>
      <ul>
        {% for c in comprobantes %}
          <li>
            <strong>#{{ c.id }}</strong> — orden_id: {{ c.orden_id }}  
            total: {{ c.total }} — fecha: {{ c.fecha.strftime('%Y-%m-%d') }}
          </li>
        {% else %}
          <li>No hay comprobantes registrados.</li>
        {% endfor %}
      </ul>
    {% endblock %}
    """, comprobantes=comprobantes)
