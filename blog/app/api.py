from app import api
from app.models import Comment

api.create_api(Comment, methods=['GET', 'POST'])