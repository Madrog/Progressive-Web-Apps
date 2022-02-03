from app import create_app, admin, db, cli
from app.models import Entry, Tag, User


app = create_app()
cli.register(app)


@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'Entry': Entry, 'Tag': Tag, 'User': User }
