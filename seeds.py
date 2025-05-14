# Rep.Mecanica/seeds.py

from app import create_app
from app.extensions import db
from app.models.usuario import User
from app.models.orden   import Orden
import datetime

app = create_app()
with app.app_context():
    # --- Seed Usuarios ---
    if User.query.count() < 15:
        for i in range(1, 16):
            email = f"user{i}@example.com"
            if not User.query.filter_by(email=email).first():
                u = User(email=email)
                u.set_password("password123")
                db.session.add(u)
        print("✅  15 usuarios creados")
        db.session.commit()
    else:
        print("⚠️  Ya hay al menos 15 usuarios, no se crean nuevos.")

    # --- Seed Órdenes ---
    if Orden.query.count() < 15:
        usuarios = User.query.limit(15).all()
        for usuario in usuarios:
            o = Orden(
                cliente_id=usuario.id,
                fecha=datetime.datetime.utcnow(),
                estado="Pendiente"
            )
            db.session.add(o)
        print("✅  15 órdenes creadas")
        db.session.commit()
    else:
        print("⚠️  Ya hay al menos 15 órdenes, no se crean nuevas.")
