from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_bootstrap import Bootstrap

from app.config import Configuration 

db = SQLAlchemy()
migrate = Migrate()
bootstrap = Bootstrap()


def create_app(config_class=Configuration):
    app = Flask(__name__)
    app.config.from_object(config_class) # use value from our configuration object
    
    db.init_app(app)
    migrate.init_app(app, db)

    bootstrap.init_app(app)

    from app.views import views
    app.register_blueprint(views, url_prefix='/')

    from app.entries.blueprint import entries
    app.register_blueprint(entries, url_prefix='/entries')

    return app


from app import models