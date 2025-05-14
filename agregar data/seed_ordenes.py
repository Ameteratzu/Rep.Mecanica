#!/usr/bin/env python
import os
import sys

# Agrega el directorio raíz del proyecto al PYTHONPATH
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

from app import create_app
from app.extensions import db
from app.models.orden import Orden
from datetime import datetime

app = create_app()
with app.app_context():
    # Solo si no hay órdenes en la base de datos
    if Orden.query.count() == 0:
        órdenes = []
        for i in range(1, 16):
            órdenes.append(
                Orden(
                    cliente_id=1,  # O reemplaza por un ID de cliente válido
                    fecha=datetime.utcnow(),
                    estado="Pendiente"
                )
            )
        db.session.add_all(órdenes)
        db.session.commit()
        print("✅  Sembradas 15 órdenes de prueba")
    else:
        print("⚠️  Ya hay órdenes; no se siembra nada.")
