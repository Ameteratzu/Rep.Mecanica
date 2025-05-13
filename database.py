
# Instalar Pymysql mediante la shell
import pymysql

# Configuración de la base de datos
db_config = {
    "host": "localhost",  # El host de la base de datos
    "user": "root",  # Tu usuario de MySQL
    "password": "",  # Tu contraseña
    "database": "Mecanica2",  # Nombre de la base de datos
    "port": 3306  # Puerto de conexión, por defecto es 3306
}

try:
    # Crear la conexión a la base de datos
    connection = pymysql.connect(**db_config)
    print("[OK] Conexión a MySQL exitosa 🚀")

    # Ejecutar una consulta de prueba
    with connection.cursor() as cursor:
        cursor.execute("SELECT DATABASE();")
        result = cursor.fetchone()
        print(f"Base de datos seleccionada: {result[0]}")

except pymysql.MySQLError as e:
    print(f"[ERROR] Error al conectar con MySQL: {e}")

finally:
    # Asegurarse de cerrar la conexión cuando no se use más
    if 'connection' in locals() and connection.open:
        connection.close()
        print("[OK] Conexión cerrada correctamente.")
