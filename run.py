# run.py

from app import create_app   # importa la función, no todo el módulo app

app = create_app()           # aquí sí obtienes la instancia de Flask

if __name__ == "__main__":
    # opcional: configura host/puerto o debug según necesites
    app.run(host="0.0.0.0", port=5000, debug=True)
