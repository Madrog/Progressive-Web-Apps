from flask import Flask
from flask.cli import FlaskGroup
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

from config import Configuration # import our configuration data

app = Flask(__name__)
app.config.from_object(Configuration) # use value from our configuration object
db = SQLAlchemy(app)
migrate = Migrate(app, db)
cli = FlaskGroup(app)



