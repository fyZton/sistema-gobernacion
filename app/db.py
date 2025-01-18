import pg8000

# Configuración de conexión a la base de datos
def get_connection():
    connection = pg8000.connect(
        host="localhost",        # Cambia a la dirección de tu servidor
        port=5432,               # Puerto por defecto de PostgreSQL
        database="servicioComunitario",   # Nombre de tu base de datos
        user="postgres",       # Tu usuario de PostgreSQL
        password="1234" # Contraseña del usuario
    )
    return connection
