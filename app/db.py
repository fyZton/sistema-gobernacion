import pg8000


def get_connection():
    connection = pg8000.connect(
        host="localhost",        
        port=5432,               
        database="servicioComunitario",   
        user="postgres",       
        password="1234" 
    )
    return connection
