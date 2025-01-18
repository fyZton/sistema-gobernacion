from flask import Flask

# Crear la instancia de la aplicación
app = Flask(__name__, static_folder='static')  # Se indica la carpeta de archivos estáticos

# Aquí se importan las rutas desde el archivo 'routes.py'
from app import routes

# Configuración adicional de Flask, como las claves para las sesiones
app.secret_key = '34d62afcf858fb77d83a64a9375ad89b'  # Cambia esto por algo más seguro
