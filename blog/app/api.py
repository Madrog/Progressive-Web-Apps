from app import api_manager
from app.models import Comment

api_manager.create_api(Comment, methods=['GET', 'POST'])