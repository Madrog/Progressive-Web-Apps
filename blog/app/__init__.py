import bcrypt
from flask import Flask, g, request, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_bootstrap import Bootstrap
from flask_login import LoginManager, current_user
from flask_bcrypt import Bcrypt 
from flask_admin import Admin, AdminIndexView, expose
from flask_restless import APIManager

from app.config import Configuration 

db = SQLAlchemy()
migrate = Migrate()
bootstrap = Bootstrap()
login_manager = LoginManager()
login_manager.login_view = "login"
bcrypt = Bcrypt()
api_manager = APIManager(flask_sqlalchemy_db=db)

class IndexView(AdminIndexView):
    @expose('/')
    def index(self):
        if not (g.user.is_authenticated and g.user.is_admin()):
            return redirect(url_for('login', next=request.path))
        return self.render('admin/index.html')

admin_dash = Admin(name='Blog Admin', template_mode='bootstrap3', index_view=IndexView())


def create_app(config_class=Configuration):
    app = Flask(__name__)
    app.config.from_object(config_class) # use value from our configuration object
    
    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)
    bootstrap.init_app(app)
    bcrypt.init_app(app)
    admin_dash.init_app(app)
    api_manager.init_app(app)
    
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

    from app import admin
    from app import api

    return app

from app import models