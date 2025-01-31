import pg8000.dbapi

def get_connection():
    try:
        print("Intentando conectar a la base de datos...")
        connection = pg8000.dbapi.connect(
            host="localhost",
            port=5432,
            database="servicioComunitario",
            user="postgres",
            password="1234"
        )
        print("Conexión exitosa a la base de datos.")
        return connection
    except Exception as e:
        print(f"Error de conexión: {e}")
        return None
