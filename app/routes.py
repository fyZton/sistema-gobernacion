from flask import render_template, request, redirect, url_for, flash, session, make_response
from app import app
from app.db import get_connection
from datetime import datetime
from werkzeug.security import check_password_hash, generate_password_hash
import pg8000
import pdfkit


pdfkit_config = pdfkit.configuration(wkhtmltopdf='C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe') 

# Función para verificar si el usuario es administrador
def es_administrador():
    return session.get('role') == 'admin' 

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/hidrolara/hidrolara1')
def hidrolara1():
    return render_template('hidrolara/hidrolara1.html')

@app.route('/hidrolara/hidrolara2')
def hidrolara2():
    return render_template('hidrolara/hidrolara2.html')

@app.route('/hidrolara/hidrolara3')
def hidrolara3():
    return render_template('hidrolara/hidrolara3.html')

@app.route('/hidrolara/hidrolara4')
def hidrolara4():
    return render_template('hidrolara/hidrolara4.html')

@app.route('/hidrolara/hidrolara5')
def hidrolara5():
    return render_template('hidrolara/hidrolara5.html')

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

        if role == 'admin':
            return redirect(url_for('admin_dashboard'))  # Redirigir al dashboard del administrador
        elif role == 'jefe_familia':
            return render_template('dashboard_jefe.html')
        elif role == 'hidrolara':
            return redirect(url_for('hidrolara_dashboard'))
        else:
            return render_template('dashboard.html')
    else:
        flash("Por favor, inicia sesión para acceder al dashboard.", "warning")
        return redirect(url_for('login'))

@app.route('/hidrolara/dashboard')
def hidrolara_dashboard():
    return render_template('hidrolara_dashboard.html')
    
@app.route('/admin/dashboard')
def admin_dashboard():
    # Verificar si el usuario es admin
    if not es_administrador():
        flash("No tienes permisos para acceder a esta página.", "error")
        return redirect(url_for('dashboard'))

    try:
        conn = get_connection()
        cursor = conn.cursor()

      
        cursor.execute("SELECT id, username, nombre, apellido, correo FROM usuarios")
        usuarios = cursor.fetchall()

    
        cursor.execute("""
            SELECT p.id, u.username, p.monto, p.fecha, p.codigo_referencia, b.nombre AS banco, ben.nombre AS beneficio
            FROM pagos p
            JOIN usuarios u ON p.usuario_id = u.id
            JOIN bancos b ON p.banco_id = b.id
            JOIN beneficios ben ON p.beneficio_id = ben.id
        """)
        pagos = cursor.fetchall()

        # Obtener lista de beneficios
        cursor.execute("SELECT id, nombre, activo FROM beneficios")
        beneficios = cursor.fetchall()

        # Obtener lista bancos
        cursor.execute("SELECT id, nombre FROM bancos")
        bancos = cursor.fetchall()

        cursor.close()
        conn.close()

        # plantilla del dashborad del admin
        return render_template('admin_dashboard.html', usuarios=usuarios, pagos=pagos, beneficios=beneficios, bancos=bancos)

    except Exception as e:
        flash(f"Error al obtener los datos: {str(e)}", "error")
        return redirect(url_for('dashboard'))

@app.route('/admin/gestionar_beneficios')
def gestionar_beneficios():
    # validar admi
    if not es_administrador():
        flash("No tienes permisos para acceder a esta página.", "error")
        return redirect(url_for('dashboard'))

    try:
        conn = get_connection()
        cursor = conn.cursor()

        
        cursor.execute("SELECT id, nombre, activo FROM beneficios")
        beneficios = cursor.fetchall()

        cursor.close()
        conn.close()

      
        return render_template('beneficios.html', beneficios=beneficios)

    except Exception as e:
        flash(f"Error al obtener los datos: {str(e)}", "error")
        return redirect(url_for('admin_dashboard'))


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

    # beneficios true
    beneficios = []
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id, nombre FROM public.beneficios WHERE activo = TRUE")
        beneficios = cursor.fetchall() 
        cursor.close()
        conn.close()
    except Exception as e:
        flash(f"Hubo un error al obtener los beneficios: {e}", "error")

    if request.method == 'POST':
        codigo_referencia = request.form.get('codigo-referencia')
        monto = request.form.get('monto')
        banco_nombre = request.form.get('banco')
        beneficio_id = request.form.get('beneficio') 

        # campos obligatorios
        if not codigo_referencia or not monto or not banco_nombre or not beneficio_id:
            flash("Todos los campos son obligatorios.", "error")
            return redirect(url_for('servicio'))

        try:
            conn = get_connection()
            cursor = conn.cursor()

           
            banco_id = get_banco_id(banco_nombre)
            if not banco_id:
                flash("Banco no válido.", "error")
                return redirect(url_for('servicio'))

            
            cursor.execute("SELECT id FROM public.usuarios WHERE username = %s", (username,))
            usuario = cursor.fetchone()
            if not usuario:
                flash("Usuario no encontrado.", "error")
                return redirect(url_for('servicio'))
            usuario_id = usuario[0]

            
            insert_query = """
                INSERT INTO pagos (usuario_id, monto, banco_id, beneficio_id, codigo_referencia, fecha)
                VALUES (%s, %s, %s, %s, %s, NOW())
                RETURNING id
            """
            cursor.execute(insert_query, (usuario_id, monto, banco_id, beneficio_id, codigo_referencia))
            pago_id = cursor.fetchone()[0]  # Obtener el ID del pago recién insertado
            conn.commit()

            cursor.close()
            conn.close()

         
            return redirect(url_for('generar_factura', pago_id=pago_id))

        except Exception as e:
            flash(f"Error al registrar el pago: {str(e)}", "error")
            return redirect(url_for('servicio'))

    return render_template('servicio.html', username=username, cedula=cedula, beneficios=beneficios)

@app.route('/generar_factura/<int:pago_id>')
def generar_factura(pago_id):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        
        cursor.execute("""
            SELECT p.id, p.monto, p.codigo_referencia, p.fecha, b.nombre AS banco, u.nombre AS usuario_nombre, u.apellido AS usuario_apellido, ben.nombre AS beneficio
            FROM pagos p
            JOIN bancos b ON p.banco_id = b.id
            JOIN usuarios u ON p.usuario_id = u.id
            JOIN beneficios ben ON p.beneficio_id = ben.id
            WHERE p.id = %s
        """, (pago_id,))
        factura_data = cursor.fetchone()

        cursor.close()
        conn.close()

        if not factura_data:
            flash("No se encontraron datos para la factura.", "error")
            return redirect(url_for('servicio'))

        
        factura = {
            "id": factura_data[0],
            "monto": factura_data[1],
            "codigo_referencia": factura_data[2],
            "fecha": factura_data[3],
            "banco": factura_data[4],
            "usuario_nombre": factura_data[5],
            "usuario_apellido": factura_data[6],
            "beneficio": factura_data[7]
        }

       
        html = render_template('factura.html', factura=factura)

        # Convertir HTML a PDF
        pdf = pdfkit.from_string(html, False, configuration=pdfkit_config)

        # Crear respuesta con el PDF
        response = make_response(pdf)
        response.headers['Content-Type'] = 'application/pdf'
        response.headers['Content-Disposition'] = f'attachment; filename=factura_{pago_id}.pdf'  # Forzar descarga

        # Mostrar un mensaje de éxito
        flash("Factura generada exitosamente.", "success")

        # Devolver la respuesta con el PDF
        return response

    except Exception as e:
        flash(f"Error al generar la factura: {str(e)}", "error")
        return redirect(url_for('dashboard'))
    
@app.route('/admin/registrar_usuario', methods=['GET', 'POST'])
def admin_registro():
    if not es_administrador():
        flash("No tienes permisos para acceder a esta página.", "error")
        return redirect(url_for('dashboard'))

    if request.method == 'POST':
        tipo_cedula = request.form['tipo_cedula']
        numero_cedula = request.form['numero_cedula']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        username = request.form['username']
        correo = request.form['correo']
        password = generate_password_hash(request.form['password'])
        rol = request.form['rol']  

        connection = get_connection()
        try:
            cursor = connection.cursor()

            
            cursor.execute("SELECT id FROM roles WHERE nombre = %s", (rol,))
            rol_result = cursor.fetchone()
            if not rol_result:
                flash("Error: No se encontró el rol.", "danger")
                return redirect(url_for('admin_registro'))
            
            rol_id = rol_result[0]

            
            query_usuarios = """
                INSERT INTO usuarios (nombre, apellido, username, correo, password, rol_id, tipo_cedula, numero_cedula)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query_usuarios, (nombre, apellido, username, correo, password, rol_id, tipo_cedula, numero_cedula))

            connection.commit()
            flash("¡Usuario registrado con éxito!", "success")
            return redirect(url_for('admin_dashboard'))

        except Exception as e:
            flash(f"Error al registrar usuario: {e}", "danger")
            connection.rollback()
        finally:
            connection.close()

    return render_template('admin_registro.html')

@app.route('/admin/crear_beneficio', methods=['POST'])
def crear_beneficio():
    if not es_administrador():
        flash("No tienes permisos para realizar esta acción.", "error")
        return redirect(url_for('admin_dashboard'))

    nombre = request.form['nombre']
    activo = request.form['activo'] == '1'  

    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO beneficios (nombre, activo) VALUES (%s, %s)", (nombre, activo))
        conn.commit()
        flash("Beneficio creado con éxito.", "success")
    except Exception as e:
        flash(f"Error al crear el beneficio: {str(e)}", "error")
        conn.rollback()
    finally:
        conn.close()

    return redirect(url_for('admin_dashboard'))

@app.route('/admin/modificar_beneficio/<int:id>', methods=['POST'])
def modificar_beneficio(id):
    if not es_administrador():
        flash("No tienes permisos para realizar esta acción.", "error")
        return redirect(url_for('admin_dashboard'))

    nombre = request.form['nombre']
    activo = request.form['activo'] == '1'  

    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE beneficios SET nombre = %s, activo = %s WHERE id = %s", (nombre, activo, id))
        conn.commit()
        flash("Beneficio modificado con éxito.", "success")
    except Exception as e:
        flash(f"Error al modificar el beneficio: {str(e)}", "error")
        conn.rollback()
    finally:
        conn.close()

    return redirect(url_for('admin_dashboard'))

@app.route('/admin/eliminar_beneficio/<int:id>', methods=['POST'])
def eliminar_beneficio(id):
    if not es_administrador():
        flash("No tienes permisos para realizar esta acción.", "error")
        return redirect(url_for('admin_dashboard'))

    try:
        conn = get_connection()
        cursor = conn.cursor()

        
        cursor.execute("UPDATE beneficios SET activo = FALSE WHERE id = %s", (id,))
        conn.commit()
        flash("Beneficio desactivado con éxito.", "success")

    except Exception as e:
        flash(f"Error al desactivar el beneficio: {str(e)}", "error")
        conn.rollback()
    finally:
        conn.close()

    return redirect(url_for('admin_dashboard'))