from flask import Blueprint, render_template, request, current_app as app


views = Blueprint('views', __name__)

@views.route('/', methods=['GET'])
def homepage():
    name = request.args.get('name')
    number = request.args.get('number')
    if not name:
        name = '<unknown>'
    if not number:
        number = 2
    return render_template('homepage.html', name=name, number=number)


    