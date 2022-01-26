from flask import flash, redirect, Blueprint, render_template, request, current_app as app, url_for
from flask_login import login_user, logout_user, current_user

from app import login_manager
from app.forms import LoginForm
from app.models import User


views = Blueprint('views', __name__)

@views.route('/', methods=['GET'])
def homepage():
    name = request.args.get('name')
    number = request.args.get('number')
    if not name:
        name = '<unknown>'
    return render_template('homepage.html', name=name, number=number)


@views.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("views.homepage"))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filer_by(email=form.email.data).first()
        if user is None or not user.check_password(form.password.data):
            flash("Invalid email or password")
            return redirect(url_for("views.login"))
        login_user(user, remember=form.remember_me.data)
        flash("Successfully logged in as %s." % user.email, "success")
        return redirect(request.args.get("next") or url_for("views.homepage"))
    return render_template("login.html", form=form)


@views.route("/logout/")
def logout():
    logout_user()
    flash("You have been logged out.", "success")
    return redirect(request.args.get('next')  or url_for('views.homepage'))




