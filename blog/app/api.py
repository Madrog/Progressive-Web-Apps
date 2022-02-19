from flask_restless import ProcessingException

from app import api_manager
from app.entries.forms import CommentForm
from app.models import Comment


def post_preprocessor(data, **kwargs):
    form = CommentForm(data=data)
    if form.validate():
        return form.data
    else:
        raise ProcessingException(
            description='Invalid form submission.',
            code=400)

api_manager.create_api(
    Comment, 
    include_columns=['id', 'name', 'url', 'body', 'created_timestamp'],
    include_methods=['gravatar'],
    methods=['GET', 'POST', 'DELETE'],
    preprocessors={
        'POST': [post_preprocessor],
    })

