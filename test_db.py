from app.db import get_connection

try:
    connection = get_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT 1")
    print("Conexión exitosa a la base de datos")
except Exception as e:
    print(f"Error al conectar con la base de datos: {e}")
finally:
    connection.close()
