from flask import Flask, request, jsonify, make_response
from flask_mongoengine import MongoEngine
from marshmallow import Schema, fields, ValidationError
from bson import ObjectId

app = Flask(__name__)
app.config['MONGODB_DB'] = 'authors'
db = MongoEngine(app)

Schema.TYPE_MAPPING[ObjectId] = fields.String

class Authors(db.Document):
    name = db.StringField()
    specialisation = db.StringField()


class AuthorsSchema(Schema):
    id = fields.String()
    name = fields.String(required=True)
    specialisation = fields.String(required=True)



@app.route('/authors', methods=['GET'])
def index():
    get_authors = Authors.objects.all()
    author_schema = AuthorsSchema(many=True, only=['id','name','specialisation'])
    try:
        authors = author_schema.dump(get_authors)
    except ValidationError as err:
        return err.messages, 422
    return make_response(jsonify({"authors": authors}))


@app.route('/authors', methods=['POST'])
def create_author():
    data = request.get_json()
    author = Authors(name=data['name'], specialisation=data["specialisation"])
    author.save()
    author_schema = AuthorsSchema(only=['name', 'specialisation'])
    authors = author_schema.dump(author)
    return make_response(jsonify({"author": authors}), 201)


@app.route('/authors/<id>', methods=['GET'])
def get_author_by_id(id):
    get_author = Authors.objects.get_or_404(id=ObjectId(id))
    author_schema = AuthorsSchema(only=['id', 'name', 'specialisation'])
    try:
        author = author_schema.dump(get_author)
    except ValidationError as err:
        return err.messages, 422
    return make_response(jsonify({"author": author}))


@app.route('/authors/<id>', methods=['PUT'])
def update_author_by_id(id):
    data = request.get_json()
    get_author = Authors.objects.get(id=ObjectId(id))
    if data.get('specialisation'):
        get_author.specialisation = data['specialisation']
    if data.get('name'):
        get_author.name = data['name']
    get_author.save()
    get_author.reload()
    author_schema = AuthorsSchema(only=['id', 'name', 'specialisation'])
    try:
        author = author_schema.dump(get_author)
    except ValidationError as err:
        return err.messages, 422
    return make_response(jsonify({"author": author}))


@app.route('/authors/<id>', methods = ['DELETE'])
def delete_author_by_id(id):
    Authors.objects(id=ObjectId(id)).delete()
    return make_response("", 204)



if __name__ == "__main__":
    app.run(debug=True)
