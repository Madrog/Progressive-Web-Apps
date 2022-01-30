import bcrypt
from flask import Flask, g, request, session
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_bootstrap import Bootstrap
from flask_login import LoginManager, current_user
from flask_bcrypt import Bcrypt 
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView

from app.config import Configuration 


db = SQLAlchemy()
migrate = Migrate()
bootstrap = Bootstrap()
login_manager = LoginManager()
login_manager.login_view = "login"
bcrypt = Bcrypt()

admin = Admin(name='Blog Admin', template_mode='bootstrap3')


def create_app(config_class=Configuration):
    app = Flask(__name__)
    app.config.from_object(config_class) # use value from our configuration object
    
    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)
    bootstrap.init_app(app)
    bcrypt.init_app(app)
    admin.init_app(app)

    from app.views import views
    app.register_blueprint(views, url_prefix='/')

    from app.entries.blueprint import entries
    app.register_blueprint(entries, url_prefix='/entries')

    @app.before_request
    def _before_request():
        g.user = current_user

    @app.before_request
    def _last_page_visited():
        if "current_page" in session:
            session["last_page"] = session["current_page"]
        session["current_page"] = request.path


    from app.models import Entry, Tag, User
    admin.add_view(ModelView(Entry, db.session))
    admin.add_view(ModelView(Tag, db.session))
    admin.add_view(ModelView(User, db.session))

    return app


from app import models