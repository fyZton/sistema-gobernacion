from flask import Flask, render_template
from db import get_connection



app = Flask(__name__, static_folder='static')  


from app import routes


app.secret_key = '34d62afcf858fb77d83a64a9375ad89b'  
