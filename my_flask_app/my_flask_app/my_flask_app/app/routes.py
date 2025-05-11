# Este archivo sirve como ejemplo para iniciar una aplicación web básica con Flask.
# Flask es un framework ligero para construir aplicaciones web que permite gestionar rutas,
# renderizar plantillas HTML y manejar lógica bajo demanda.
# Este archivo define una aplicación simple con una sola ruta y una plantilla HTML.

from flask import Flask, render_template  # Flask para la aplicación, render_template para cargar plantillas HTML.

# Inicialización de la aplicación Flask.
# La configuración 'template_folder' indica la ubicación de los archivos HTML dentro del proyecto.
app = Flask(__name__, template_folder="app/templates")


@app.route('/')  # Define la URL raíz ('/'), que actúa como la página principal de la aplicación.
def index():
    # Renderiza y muestra el archivo HTML llamado 'index.html'.
    # Este archivo debe estar en el directorio especificado en 'template_folder'.
    return render_template('index.html')


# Bloque principal: El servidor sólo se ejecutará si este archivo es ejecutado directamente.
# Esto evita que el servidor Flask se inicie al importar este archivo como módulo en otro script.
if __name__ == '__main__':
    # Activa el modo de depuración (debug=True) durante el desarrollo.
    # Esto reinicia automáticamente el servidor cuando hay cambios en el código
    # y muestra mensajes detallados de error en el navegador.
    app.run(debug=True)

# PROPÓSITO:
# Este archivo inicializa un servidor web que responde a solicitudes en la ruta raíz ('/'),
# mostrando contenido HTML renderizado dinámicamente desde la carpeta configurada.
# Es la base para cualquier proyecto Flask más complejo.

# ESTRUCTURA DE UN PROYECTO FLASK BASADO EN ESTE ARCHIVO:
# Se sugiere la siguiente estructura típica:
#
# ├── app/
# │   ├── templates/        # Contiene las plantillas HTML renderizadas por Flask.
# │   │   └── index.html    # Archivo HTML renderizado cuando se accede a la ruta raíz.
# │   └── static/           # Opcional: contiene recursos como CSS, JavaScript e imágenes.
# ├── main.py               # Este archivo, encargado de iniciar el servidor Flask.
# ├── config.py             # Configuraciones del proyecto (ej. credenciales de base de datos).
# └── requirements.txt      # Lista de dependencias del proyecto (incluye Flask).

# PASOS PARA USO:
# 1. Instalar Flask: Ejecuta `pip install flask`.
# 2. Crear un archivo 'index.html' dentro de 'app/templates'.
# 3. Ejecutar el archivo con `python main.py`.
# 4. Abrir un navegador y visitar la URL 'http://127.0.0.1:5000/' para verificar el resultado.

# EJEMPLO DE EXTENSIÓN:
# Agregar nuevas rutas para diversas funcionalidades:
#
# @app.route('/about')
# def about():
#     # Renderiza un archivo HTML llamado 'about.html' para la página "Acerca de".
#     return render_template('about.html')

# Esto permite manejar múltiples páginas desde el mismo servidor Flask.
