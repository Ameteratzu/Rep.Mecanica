import pyodbc

# Configuración de la conexión
SERVER = "DESKTOP-985V681\\patrick"
DATABASE = "mi_basedatos"  # Cambia esto por el nombre de tu base de datos
DRIVER = "ODBC Driver 17 for SQL Server"  # Driver recomendado para conectar
USERNAME = ""  # Déjalo vacío si usas Trusted Connection (autenticación de Windows)
PASSWORD = ""  # Déjalo vacío si usas Trusted Connection (autenticación de Windows)


def get_connection():
    try:
        if USERNAME and PASSWORD:  # Autenticación mediante usuario y contraseña
            connection_string = (
                f"DRIVER={{{DRIVER}}};"
                f"SERVER={SERVER};"
                f"DATABASE={DATABASE};"
                f"UID={USERNAME};"
                f"PWD={PASSWORD};"
            )
        else:  # Autenticación confiable (Windows Authentication)
            connection_string = (
                f"DRIVER={{{DRIVER}}};"
                f"SERVER={SERVER};"
                f"DATABASE={DATABASE};"
                "Trusted_Connection=yes;"  # Sin usuario ni contraseña
            )

        # Intentar realizar la conexión
        connection = pyodbc.connect(connection_string)
        print("[INFO] Conexión a SQL Server exitosa 🚀")
        return connection
    except Exception as e:
        print(f"[ERROR] Error al conectar con SQL Server: {e}")
        return None
