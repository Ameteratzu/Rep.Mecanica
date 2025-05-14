from flask import Blueprint, render_template_string
from flask_login import login_required
from app.models.producto import Producto

products_bp = Blueprint("products", __name__, url_prefix="/productos")

@products_bp.route("/", methods=["GET"])
@login_required
def list_products():
    productos = Producto.query.order_by(Producto.id).all()
    return render_template_string("""
    {% extends "base.html" %}
    {% block content %}
      <h1>Productos</h1>
      <ul>
        {% for p in productos %}
          <li>
            <strong>#{{ p.id }}</strong> — {{ p.nombre }}  
            (precio: {{ p.precio }})
          </li>
        {% else %}
          <li>No hay productos registrados.</li>
        {% endfor %}
      </ul>
    {% endblock %}
    """, productos=productos)
