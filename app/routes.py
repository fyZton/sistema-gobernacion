from flask import render_template, request, redirect, url_for, flash, session
from app import app
from app.db import get_connection
from datetime import datetime

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Conectar a la base de datos
        connection = get_connection()
        try:
            cursor = connection.cursor()
            # Consulta SQL con valores de usuario y contraseña
            query = "SELECT id, username, role FROM usuarios WHERE username = %s AND password = %s"
            cursor.execute(query, (username, password))
            user = cursor.fetchone()  # Obtén el usuario si existe
            print(f"[DEBUG] Resultado de la consulta: {user}")  # Depuración
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  # Depuración
            flash("Error al conectar con la base de datos.", "danger")
            user = None
        finally:
            connection.close()

        if user:
            # Guardar la sesión si el usuario existe
            session['logged_in'] = True
            session['user_id'] = user[0]
            session['username'] = user[1]
            session['role'] = user[2]
            flash("¡Inicio de sesión exitoso!", "success")
            print(f"[DEBUG] Usuario autenticado: {user[1]}")  # Depuración
            return redirect(url_for('dashboard'))
        else:
            flash("Usuario o contraseña incorrectos.", "danger")
            print("[DEBUG] Credenciales incorrectas")  # Depuración

    return render_template('login.html')
"""
@app.route('/login_jefe', methods=['GET', 'POST'])
def login_jefe():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Lógica para autenticar a los jefes de comuna
        connection = get_connection()
        try:
            cursor = connection.cursor()
            query = "SELECT id, username, password, role FROM usuario WHERE username = %s"
            cursor.execute(query, (username,))
            user = cursor.fetchone()
            print(f"[DEBUG] Usuario encontrado: {user}")  # Verifica si el usuario se encuentra correctamente
        except Exception as e:
            flash("Error al conectar con la base de datos.", "danger")
            user = None
        finally:
            connection.close()

        # Verifica si el usuario existe y si la contraseña es correcta
        if user:
            print(f"[DEBUG] Contraseña ingresada: {password}, Contraseña en base de datos: {user[2]}")  # Compara las contraseñas
            if user[2] == password:  # Comparar directamente las contraseñas sin usar check_password_hash
                # Verifica que el rol sea 'jefe_comuna'
                if user[3] == 'jefe_comuna':  # user[3] es el campo de rol
                    print(f"[DEBUG] Autenticación exitosa para {username}")  # Verifica si la autenticación es exitosa
                    session['logged_in'] = True
                    session['user_id'] = user[0]
                    session['username'] = user[1]
                    session['role'] = user[3]
                    flash("¡Inicio de sesión exitoso como Jefe de Comuna!", "success")
                    return redirect(url_for('dashboard_jefe'))  # Redirige al dashboard si todo es correcto
                else:
                    flash("Acceso denegado: No tienes el rol de Jefe de Comuna.", "danger")
            else:
                flash("Usuario o contraseña incorrectos.", "danger")
        else:
            flash("Usuario no encontrado.", "danger")

    return render_template('login_jefe.html')  # Aquí se carga la plantilla de login para jefes de comuna

@app.route('/dashboard_jefe')
def dashboard_jefe():
    if 'logged_in' in session and session.get('role') == 'jefe_comuna':
        return render_template('dashboard_jefe.html', username=session.get('username'))
    else:
        flash("Acceso no autorizado.", "danger")
        return redirect(url_for('login_jefe'))  # Si no es jefe de comuna, lo redirige al login de jefe de comuna
        """

@app.route('/dashboard')
def dashboard():
    if session.get('logged_in'):
        username = session.get('username', "Usuario")
        role = session.get('role', "Sin rol")
        return render_template('dashboard.html', username=username, role=role)
    else:
        flash("Por favor, inicia sesión para acceder al dashboard.", "warning")
        return redirect(url_for('login'))
    
@app.route('/gas', methods=['GET', 'POST'])
def gas():
    if request.method == 'POST':
        # Recoger los datos del formulario
        jefe_familia = request.form['jefe-familia']
        cedula = request.form['cedula']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']
        codigo_referencia = request.form['codigo-referencia']
        fecha_pago = request.form['fecha-pago']
        
        # Convertir la fecha de pago en formato adecuado
        fecha_pago = datetime.strptime(fecha_pago, '%d/%m/%y').strftime('%Y-%m-%d')

        # Obtener el ID del usuario desde la sesión
        usuario_id = session.get('user_id')  # Suponiendo que el usuario está logueado

        # Conectar a la base de datos
        connection = get_connection()
        try:
            cursor = connection.cursor()
            # Consulta SQL para insertar los datos en la tabla pagos_gas
            query = """
                INSERT INTO pagos_gas (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en)
                VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), NOW())
            """
            # Ejecutar la consulta con los valores del formulario
            cursor.execute(query, (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago))
            connection.commit()
            flash("¡Pago registrado con éxito!", "success")
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  # Depuración
            flash("Error al registrar el pago en la base de datos.", "danger")
        finally:
            connection.close()

        # Redirigir al dashboard después de registrar el pago
        return redirect(url_for('dashboard'))

    return render_template('gas.html')


@app.route('/clap', methods=['GET', 'POST'])
def clap():
    if request.method == 'POST':
        # Recoger los datos del formulario
        jefe_familia = request.form['jefe-familia']
        cedula = request.form['cedula']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']
        codigo_referencia = request.form['codigo-referencia']
        fecha_pago = request.form['fecha-pago']
        
        # Convertir la fecha de pago en formato adecuado
        fecha_pago = datetime.strptime(fecha_pago, '%d/%m/%y').strftime('%Y-%m-%d')

        # Obtener el ID del usuario desde la sesión
        usuario_id = session.get('user_id')  # Suponiendo que el usuario está logueado

        # Conectar a la base de datos
        connection = get_connection()
        try:
            cursor = connection.cursor()
            # Consulta SQL para insertar los datos en la tabla pagos_clap
            query = """
                INSERT INTO pagos_clap (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en)
                VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), NOW())
            """
            # Ejecutar la consulta con los valores del formulario
            cursor.execute(query, (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago))
            connection.commit()
            flash("¡Pago registrado con éxito!", "success")
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  # Depuración
            flash("Error al registrar el pago en la base de datos.", "danger")
        finally:
            connection.close()

        # Redirigir al dashboard después de registrar el pago
        return redirect(url_for('dashboard'))

    return render_template('clap.html')  # O lo que sea que quieras que haga esta ruta


@app.route('/otros', methods=['GET', 'POST'])
def otros():
    if request.method == 'POST':
        # Recoger los datos del formulario
        jefe_familia = request.form['jefe-familia']
        cedula = request.form['cedula']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']
        codigo_referencia = request.form['codigo-referencia']
        fecha_pago = request.form['fecha-pago']
        
        # Convertir la fecha de pago en formato adecuado
        fecha_pago = datetime.strptime(fecha_pago, '%d/%m/%y').strftime('%Y-%m-%d')

        # Obtener el ID del usuario desde la sesión
        usuario_id = session.get('user_id')  # Suponiendo que el usuario está logueado

        # Conectar a la base de datos
        connection = get_connection()
        try:
            cursor = connection.cursor()
            # Consulta SQL para insertar los datos en la tabla pagos_otros
            query = """
                INSERT INTO pagos_otros (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en)
                VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), NOW())
            """
            # Ejecutar la consulta con los valores del formulario
            cursor.execute(query, (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago))
            connection.commit()
            flash("¡Pago registrado con éxito!", "success")
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  # Depuración
            flash("Error al registrar el pago en la base de datos.", "danger")
        finally:
            connection.close()

        # Redirigir al dashboard después de registrar el pago
        return redirect(url_for('dashboard'))

    return render_template('otros.html')  # O lo que sea que quieras que haga esta ruta


@app.route('/contacto')
def contacto():
    return render_template('contacto.html')

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    session.pop('user_id', None)
    session.pop('username', None)
    session.pop('role', None)
    flash("Has cerrado sesión.", "info")
    return redirect(url_for('login'))
