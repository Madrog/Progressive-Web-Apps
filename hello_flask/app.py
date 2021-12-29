from flask import Flask, abort, request

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello, Flask!'


@app.route('/hello/<name>')
@app.route('/hello/')
def hello(name=None):
    if name is None:
        # If no name is specified in the URL, attempt to retrieve it
        # from the query string.
        name = request.args.get('name')
        if name:
            return 'Hello, %s' % name
    else: 
        # No name was specified in the URL or the query string
        abort(404)



if __name__ == '__main__':
    app.run(debug=True)