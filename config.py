# config.py

import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    # Clave secreta para Flask y itsdangerous
    SECRET_KEY = os.environ.get("SECRET_KEY", "cambiar-por-una-secreta-y-larga")

    # Salt para los tokens de recuperación de contraseña
    SECURITY_PASSWORD_SALT = os.environ.get("SECURITY_PASSWORD_SALT", "otra-salt-larga")

    # Configuración de la base de datos
    # SQLALCHEMY_DATABASE_URI    = os.environ.get("DATABASE_URL", "mysql+pymysql://root:Danita2107@localhost:3306/mecanica2")
    SQLALCHEMY_DATABASE_URI = os.environ.get("DATABASE_URL", "mysql+pymysql://root:@localhost:3307/mecanica2")

    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Configuración de Flask-Mail
    MAIL_SERVER = "smtp.gmail.com"
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = "quispeamet2@gmail.com"
    MAIL_PASSWORD = "tholrtcfzuoyodup"  # <--- Tu contraseña de aplicación aquí, sin espacios
    MAIL_DEFAULT_SENDER = "quispeamet2@gmail.com"  # Mejor usar tu mismo correo de Gmail
    MAIL_SUBJECT_PREFIX = "[RepMecanica] "

