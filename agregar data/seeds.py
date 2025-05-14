# seeds.py
from datetime import datetime
from app import create_app
from app.extensions import db
from app.models.usuario import User
from app.models.orden import Orden
# Si tienes modelos de comprobantes o productos:
# from app.models.comprobante import Comprobante
# from app.models.producto import Producto

app = create_app()

with app.app_context():
    ### 1) Usuarios de prueba ###
    if User.query.count() < 15:
        for i in range(1, 16):
            email = f"user{i}@example.com"
            if not User.query.filter_by(email=email).first():
                u = User(email=email)
                u.set_password("password123")
                db.session.add(u)
        print("✅  Sembrados 15 usuarios de prueba")
        db.session.commit()
    else:
        print("⚠️  Ya hay al menos 15 usuarios, no se crean nuevos.")

    ### 2) Órdenes de prueba ###
    if Orden.query.count() < 15:
        # Usa el id de un usuario real; aquí asumimos que el usuario 1 existe
        for i in range(1, 16):
            o = Orden(
                cliente_id=1,
                fecha=datetime.utcnow(),
                estado="Pendiente"
            )
            db.session.add(o)
        print("✅  Sembradas 15 órdenes de prueba")
        db.session.commit()
    else:
        print("⚠️  Ya hay al menos 15 órdenes, no se crean nuevas.")

    ### 3) (Opcional) Comprobantes de prueba ###
    # if Comprobante.query.count() < 15:
    #     for i in range(1,16):
    #         c = Comprobante(
    #             orden_id=1,
    #             fecha=datetime.utcnow(),
    #             total=100.0 * i
    #         )
    #         db.session.add(c)
    #     print("✅  Sembrados 15 comprobantes de prueba")
    #     db.session.commit()

    ### 4) (Opcional) Productos de prueba ###
    # if Producto.query.count() < 15:
    #     for i in range(1,16):
    #         p = Producto(
    #             nombre=f"Producto {i}",
    #             precio=10.0 * i
    #         )
    #         db.session.add(p)
    #     print("✅  Sembrados 15 productos de prueba")
    #     db.session.commit()
