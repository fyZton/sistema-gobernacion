from flask import render_template, request, redirect, url_for, flash, session
from app import app
from app.db import get_connection
from datetime import datetime
from werkzeug.security import check_password_hash
import pg8000



@app.route('/')
def home():
    return redirect(url_for('login'))


from werkzeug.security import generate_password_hash

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        tipo_cedula = request.form['tipo_cedula']
        numero_cedula = request.form['numero_cedula']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        username = request.form['username']
        correo = request.form['correo']
        password = generate_password_hash(request.form['password'])
        jefe_familia = request.form['jefe_familia']  # 'si' o 'no'

        connection = get_connection()
        try:
            cursor = connection.cursor()

            # Determinar rol de usuario
            if jefe_familia == 'si':
                cursor.execute("SELECT id FROM roles WHERE nombre = %s", ('jefe_familia',))
            else:
                cursor.execute("SELECT id FROM roles WHERE nombre = %s", ('usuario_normal',))
            
            rol_result = cursor.fetchone()
            if not rol_result:
                flash("Error: No se encontró el rol.", "danger")
                return redirect(url_for('registro'))
            
            rol_id = rol_result[0]

            # Insertar en tabla usuarios tipo_cedula y numero_cedula
            query_usuarios = """
                INSERT INTO usuarios (nombre, apellido, username, correo, password, rol_id, tipo_cedula, numero_cedula)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query_usuarios, (nombre, apellido, username, correo, password, rol_id, tipo_cedula, numero_cedula))

            connection.commit()
            flash("¡Registro exitoso! Puedes iniciar sesión.", "success")
            return redirect(url_for('login'))

        except Exception as e:
            flash(f"Error al registrar usuario: {e}", "danger")
            connection.rollback()
        finally:
            connection.close()

    return render_template('registro.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        connection = get_connection()
        try:
            cursor = connection.cursor()
            query = """
                SELECT u.id, u.username, u.password, u.rol_id, r.nombre, u.tipo_cedula, u.numero_cedula 
                FROM usuarios u
                JOIN roles r ON u.rol_id = r.id
                WHERE u.username = %s
            """
            cursor.execute(query, (username,))
            user = cursor.fetchone()
            
            if user:
                if check_password_hash(user[2], password):  # Verificar la pw
                    session['logged_in'] = True
                    session['user_id'] = user[0]
                    session['username'] = user[1]
                    session['role'] = user[4]
                    session['numero_cedula'] = f"{user[5]}-{user[6]}"  # guardar cedula completa
                    flash("¡Inicio de sesión exitoso!", "success")
                    return redirect(url_for('dashboard'))
                else:
                    flash("Usuario o contraseña incorrectos.", "danger")
            else:
                flash("Usuario no encontrado.", "danger")
        except Exception as e:
            flash("Error al conectar con la base de datos.", "danger")
        finally:
            connection.close()

    return render_template('login.html')





@app.route('/dashboard')
def dashboard():
    if session.get('logged_in'):
        role = session.get('role')

        if role == 'administrador':
            # en creacion para admin
            return render_template('dashboard_admin.html')
        elif role == 'jefe_familia':
            # en creacion para jefe de familia
            return render_template('dashboard_jefe.html')
        else:
            # Vista para usuarios total
            return render_template('dashboard.html')


    else:
        flash("Por favor, inicia sesión para acceder al dashboard.", "warning")
        return redirect(url_for('login'))

    
@app.route('/gas', methods=['GET'])
def gas():
    conn = get_connection()
    cursor = conn.cursor()

    try:
        # Consulta para obtener el nombre de usuario
        cursor.execute("SELECT username FROM usuarios WHERE id = 1")  # Cambia según tu caso
        result = cursor.fetchone()
        username = result[0] if result else None

        # Consulta para obtener la cédula
        cursor.execute("SELECT numero_cedula FROM usuarios WHERE id = 1")  # Ajustado a la nueva estructura
        result = cursor.fetchone()
        cedula = result[0] if result else None

        # Consulta para obtener la cantidad de miembros
        cursor.execute("SELECT COUNT(*) FROM usuarios")
        result = cursor.fetchone()
        member_count = result[0] if result else 0

        # mostrar mensaje y evitar errores
        if username is None or cedula is None:
            flash("No se encontraron datos para el usuario", "warning")
            return redirect(url_for('dashboard'))

    except Exception as e:
        flash(f"Error al obtener datos: {e}", "danger")
        return redirect(url_for('dashboard'))  # Redirigir con error

    finally:
        cursor.close()
        conn.close()

    # render pantalla si funciona
    return render_template('gas.html', username=username, cedula=cedula, member_count=member_count)

@app.route('/clap', methods=['GET', 'POST'])
def clap():
    if request.method == 'POST':
        
        jefe_familia = request.form['jefe-familia']
        cedula = request.form['cedula']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']
        codigo_referencia = request.form['codigo-referencia']
        fecha_pago = request.form['fecha-pago']
        
        
        fecha_pago = datetime.strptime(fecha_pago, '%d/%m/%y').strftime('%Y-%m-%d')

        
        usuario_id = session.get('user_id')  

        
        connection = get_connection()
        try:
            cursor = connection.cursor()
            
            query = """
                INSERT INTO pagos_clap (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en)
                VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), NOW())
            """
            
            cursor.execute(query, (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago))
            connection.commit()
            flash("¡Pago registrado con éxito!", "success")
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  
            flash("Error al registrar el pago en la base de datos.", "danger")
        finally:
            connection.close()

        
        return redirect(url_for('dashboard'))

    return render_template('clap.html')  


@app.route('/otros', methods=['GET', 'POST'])
def otros():
    if request.method == 'POST':
        
        jefe_familia = request.form['jefe-familia']
        cedula = request.form['cedula']
        cantidad = request.form['cantidad']
        descripcion = request.form['descripcion']
        codigo_referencia = request.form['codigo-referencia']
        fecha_pago = request.form['fecha-pago']
        
        
        fecha_pago = datetime.strptime(fecha_pago, '%d/%m/%y').strftime('%Y-%m-%d')

        
        usuario_id = session.get('user_id')  

        
        connection = get_connection()
        try:
            cursor = connection.cursor()
            
            query = """
                INSERT INTO pagos_otros (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en)
                VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), NOW())
            """
            
            cursor.execute(query, (usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago))
            connection.commit()
            flash("¡Pago registrado con éxito!", "success")
        except Exception as e:
            print(f"[DEBUG] Error en la base de datos: {e}")  
            flash("Error al registrar el pago en la base de datos.", "danger")
        finally:
            connection.close()

        
        return redirect(url_for('dashboard'))

    return render_template('otros.html')  


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

def get_banco_id(banco_nombre):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM public.bancos WHERE nombre = %s", (banco_nombre,))
        banco_id = cursor.fetchone()
        cursor.close()
        conn.close()
        return banco_id[0] if banco_id else None
    except Exception as e:
        print(f"Error al obtener el ID del banco: {e}")
        return None
    
@app.route('/servicio', methods=['GET', 'POST'])
def servicio():
    username = session.get('username')
    cedula = session.get('numero_cedula')

    # Obtener beneficios activos
    beneficios = []
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id, nombre FROM public.beneficios WHERE activo = TRUE")
        beneficios = cursor.fetchall()  # Lista de tuplas [(id, nombre)]
        cursor.close()
        conn.close()
    except Exception as e:
        flash(f"Hubo un error al obtener los beneficios: {e}", "error")

    if request.method == 'POST':
        codigo_referencia = request.form.get('codigo-referencia')
        monto = request.form.get('monto')
        banco_nombre = request.form.get('banco')
        beneficio_id = request.form.get('beneficio')  # ID del beneficio seleccionado

        # Validar campos obligatorios
        if not codigo_referencia or not monto or not banco_nombre or not beneficio_id:
            flash("Todos los campos son obligatorios.", "error")
            return redirect(url_for('servicio'))

        try:
            conn = get_connection()
            cursor = conn.cursor()

            # Obtener el ID del banco
            banco_id = get_banco_id(banco_nombre)
            print(f"Banco seleccionado: {banco_nombre}, ID obtenido: {banco_id}")  # Depuración
            if not banco_id:
                flash("Banco no válido.", "error")
                return redirect(url_for('servicio'))

            # Obtener el ID del usuario
            cursor.execute("SELECT id FROM public.usuarios WHERE username = %s", (username,))
            usuario = cursor.fetchone()
            if not usuario:
                flash("Usuario no encontrado.", "error")
                return redirect(url_for('servicio'))
            usuario_id = usuario[0]

            # Insertar el pago
            insert_query = """
                INSERT INTO pagos (usuario_id, monto, banco_id, beneficio_id, codigo_referencia, fecha)
                VALUES (%s, %s, %s, %s, %s, NOW())
            """
            cursor.execute(insert_query, (usuario_id, monto, banco_id, beneficio_id, codigo_referencia))
            conn.commit()

            cursor.close()
            conn.close()

            flash("Pago registrado exitosamente.", "success")
            return redirect(url_for('dashboard'))

        except Exception as e:
            flash(f"Error al registrar el pago: {str(e)}", "error")
            return redirect(url_for('servicio'))

    return render_template('servicio.html', username=username, cedula=cedula, beneficios=beneficios)