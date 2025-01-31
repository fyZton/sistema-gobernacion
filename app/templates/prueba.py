from werkzeug.security import generate_password_hash

# Generar la contraseña encriptada
password = generate_password_hash('admin')

# Imprimir la contraseña encriptada para usarla en la consulta SQL
print(password)