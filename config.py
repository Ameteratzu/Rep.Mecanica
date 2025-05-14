
import os

class Config:
    SECRET_KEY               = os.getenv("SECRET_KEY", "una_clave_segura")
    SQLALCHEMY_DATABASE_URI  = "mysql+pymysql://root:@127.0.0.1:3307/Mecanica2"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Flask-Mail (Gmail SMTP con App Password)
    MAIL_SERVER         = "smtp.gmail.com"
    MAIL_PORT           = 587
    MAIL_USE_TLS        = True
    MAIL_USERNAME       = os.getenv("MAIL_USER", "quispeamet2@gmail.com")
    MAIL_PASSWORD       = os.getenv("MAIL_PASS", "taosoffgsxifnuyd")
    MAIL_DEFAULT_SENDER = MAIL_USERNAME

    # ItsDangerous
    SECURITY_PASSWORD_SALT = os.getenv("SECURITY_SALT", "salty1234")
