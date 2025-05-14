from flask import Flask
from flask_mail import Mail, Message
from config import Config

app = Flask(__name__)
app.config.from_object(Config)

mail = Mail(app)

with app.app_context():
    msg = Message(
        subject="Prueba de envío – TECMECH",
        recipients=["quispeamet2@gmail.com"],
        body="Este es un correo de prueba enviado vía SMTP de Gmail."
    )
    mail.send(msg)
    print("✅ Correo enviado (o en cola) correctamente.")
