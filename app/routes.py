from flask import render_template, request, redirect, url_for, flash
from app import app

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == "admin" and password == "password":
            flash("Login successful!", "success")
            return redirect(url_for('dashboard'))
        else:
            flash("Invalid username or password.", "danger")
    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html', username="admin")

@app.route('/settings')
def settings():
    return "<h1>Settings Page</h1>"

@app.route('/logout')
def logout():
    flash("You have been logged out.", "info")
    return redirect(url_for('login'))

@app.route('/profile')  # Nueva ruta para el perfil
def profile():
    return "<h1>Your Profile</h1>"
