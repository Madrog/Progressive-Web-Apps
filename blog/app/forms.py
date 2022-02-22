import g

from flask_wtf import FlaskForm, HiddenField
from wtforms import StringField, BooleanField, PasswordField
from wtforms.validators import DataRequired, Length

from app.models import User

class CSRFMixin(object):
    @staticmethod
    @app.before_request
    def add_csrf():
        self._csrf_token = HiddenField(default=g._csrf_token)


class LoginForm(FlaskForm, CSRFMixin):
    email = StringField("Email", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])
    remember_me = BooleanField("Remember me?", default=True)

    def validate(self):
        if not super(LoginForm, self).validate():
            return False

        self.user = User.authenticate(self.email.data, self.password.data)
        if not self.user:
            self.email.errors.append("Invalid email or password.")
            return False
        
        return True