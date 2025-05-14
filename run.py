# Rep.Mecanica/run.py

from flask               import Flask
from flask_login         import LoginManager
from itsdangerous        import URLSafeTimedSerializer
import app.extensions     as ext
from config              import Config
from app.routes          import main as main_blueprint

def create_app():
    print("1️⃣  Creamos la app Flask")
    app = Flask(
        __name__,
        template_folder="app/templates",
        static_folder="app/static"
    )

    print("2️⃣  Cargamos configuración")
    app.config.from_object(Config)

    print("3️⃣  Inicializamos extensiones")
    ext.db.init_app(app)
    ext.mail.init_app(app)
    ext.ts = URLSafeTimedSerializer(app.config["SECRET_KEY"])

    print("4️⃣  Configuramos Flask-Login")
    login_manager = LoginManager(app)
    login_manager.login_view = "main.login"
    login_manager.login_message_category = "warning"

    from app.models import User
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    print("5️⃣  Registramos Blueprint")
    app.register_blueprint(main_blueprint)

    # <--  Todo lo que toca la base de datos debe ir dentro de este bloque:
    with app.app_context():
        print("🗑️  Borrando tablas antiguas…")
        ext.db.drop_all()         # drop_all dentro del app_context
        print("✅  Tablas viejas borradas")
        print("6️⃣  Creando tablas nuevas…")
        ext.db.create_all()       # create_all también dentro
        print("7️⃣  Tablas creadas correctamente")

    return app

if __name__ == "__main__":
    print("8️⃣  Arrancando servidor")
    create_app().run(debug=True, use_reloader=False)
