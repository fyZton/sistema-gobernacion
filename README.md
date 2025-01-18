# Bella Vista App

**Descripción:**  
Bella Vista es una aplicación web destinada al registro y control de pagos en el barrio Bella Vista. Los usuarios pueden registrar pagos de servicios como gas, CLAP, y otros pagos comunes. La aplicación está construida con Flask, un framework de Python, y utiliza una base de datos PostgreSQL para almacenar la información.

---

## Requisitos

Para ejecutar el proyecto, necesitarás tener instalados los siguientes programas:

- **Python 3.8+**  
- **Flask**  
- **PostgreSQL**  
- **(Opcional) pgAdmin** para gestionar la base de datos de forma visual

---

## Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/tu_usuario/bellavista-app.git
   cd bellavista-app
   ```

2. **Instalar las dependencias de Python:**

   Si no tienes un entorno virtual, crea uno:

   ```bash
   python -m venv venv
   ```

   Activa el entorno virtual:

   - En **Windows**:  
     ```bash
     venv\Scripts\activate
     ```

   - En **Linux/Mac**:  
     ```bash
     source venv/bin/activate
     ```

   Instala las dependencias:

   ```bash
   pip install -r requirements.txt
   ```

3. **Configuración de la base de datos:**

   Asegúrate de tener PostgreSQL instalado y configurado. Puedes usar `pgAdmin` para gestionar la base de datos si lo prefieres.

   - Crea una base de datos llamada `servicioComunitario`.
   - Ejecuta el archivo `bellavista.sql` para crear las tablas necesarias en la base de datos.

   ```bash
   psql -U tu_usuario -d servicioComunitario -f bellavista.sql
   ```

4. **Configuración del archivo de entorno:**

   Asegúrate de tener configurada la variable de entorno `FLASK_APP` apuntando a tu archivo `run.py`:

   ```bash
   export FLASK_APP=run.py
   ```

---

## Ejecutar el Proyecto

1. Para iniciar la aplicación, usa el siguiente comando:

   ```bash
   python run.py
   ```

   Esto levantará el servidor de Flask en modo de desarrollo (por defecto en `http://127.0.0.1:5000/`).

2. Accede a la aplicación desde tu navegador en la dirección indicada.

---

## Estructura de Archivos

```plaintext
bellavista-app/
│
├── app/
│   ├── __init__.py      # Inicialización de la aplicación Flask
│   ├── routes.py        # Rutas de la aplicación
│
├── static/              # Archivos estáticos (CSS, imágenes)
│   ├── disenos.css      # Estilos de la aplicación
│   ├── imagenes/        # Imágenes utilizadas
│
├── run.py               # Archivo principal para ejecutar la app
├── bellavista.sql       # Script para crear la base de datos
├── README.md            # Este archivo
├── test_db.py           # Archivo de prueba para la base de datos
```

