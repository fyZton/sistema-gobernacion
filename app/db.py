import pg8000

def get_connection():
    try:
        print("Intentando conectar a la base de datos...")  #ver si ejecuta la funcion
        connection = pg8000.connect(
            host="localhost",        
            port=5432,               
            database="servicioComunitario",   
            user="postgres",       
            password="1234" 
        )
        print("Conexión exitosa a la base de datos.")  #si sirve
        return connection
    except Exception as e:
        print(f"Error de conexión: {e}")  #no sirve, muestra el error
        return None
