from flask import Flask

app = Flask(__name__)
app.config['SECRET_KEY'] = '34d62afcf858fb77d83a64a9375ad89b'

from app import routes
