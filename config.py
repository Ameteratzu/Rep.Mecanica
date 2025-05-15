# config.py

import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    # Clave secreta para Flask y itsdangerous
    SECRET_KEY = os.environ.get("SECRET_KEY", "cambiar-por-una-secreta-y-larga")

    # Salt para los tokens de recuperación de contraseña
    SECURITY_PASSWORD_SALT = os.environ.get("SECURITY_PASSWORD_SALT", "otra-salt-larga")

    # Configuración de la base de datos
    SQLALCHEMY_DATABASE_URI    = os.environ.get("DATABASE_URL", "mysql+pymysql://root:@localhost:3306/Mecanica2")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Configuración de Flask-Mail
    MAIL_SERVER   = os.environ.get("MAIL_SERVER", "smtp.gmail.com")
    MAIL_PORT     = int(os.environ.get("MAIL_PORT", "587"))
    MAIL_USE_TLS  = os.environ.get("MAIL_USE_TLS", "true").lower() in ("true","1","yes")
    MAIL_USERNAME = os.environ.get("MAIL_USERNAME", "quispeamet2@gmail.com")
    MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD", "taosoffgsxifnuyd")
    MAIL_DEFAULT_SENDER    = os.environ.get("MAIL_DEFAULT_SENDER", "no-reply@example.com")
    MAIL_SUBJECT_PREFIX    = os.environ.get("MAIL_SUBJECT_PREFIX", "[RepMecanica] ")

    # Opcional: configuración de paginación, etc.
