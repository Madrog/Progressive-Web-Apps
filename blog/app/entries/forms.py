from typing import Optional
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, SelectField, FileField, HiddenField
from wtforms.validators import DataRequired, Length, Optional, URL

from app.models import Entry, Tag

class TagField(StringField):
    def _value(self):
        if self.data:
            # Display tags as a comma-separated list
            return ', '.join([tag.name for tag in self.data])
        return ''

    def get_tags_from_string(self, tag_string):
        raw_tags = tag_string.split(',')

        # Filter out any empty tag names.
        tag_names = [name.strip() for name in raw_tags if name.strip()]

        # Query the database and retrieve any tags we have already saved.
        existing_tags = Tag.query.filter(Tag.name.in_(tag_names))

        # Determine which tag names are new.
        new_names = set(tag_names) - set([tag.name for tag in existing_tags])

        # Create a list of unsaved Tag instances for the new tags.
        new_tags = [Tag(name=name) for name in new_names]

        # Return all the existing tags + all the new, unsaved tags.
        return list(existing_tags) + new_tags

    
    def process_formdata(self, valuelist):
        if valuelist:
            self.data = self.get_tags_from_string(valuelist[0])
        else:
            self.data = []


class ImageForm(FlaskForm):
    file = FileField('Image file')


class EntryForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired()])
    body = TextAreaField('Body', validators=[DataRequired(), Length(min=0, max=140)])
    status = SelectField(
        'Entry status',
        choices=(
            (Entry.STATUS_PUBLIC, 'Public'),
            (Entry.STATUS_DRAFT, 'Draft')),
            coerce=int)
    tags = TagField('Tags',
                description='Separate multiple tags with commas.')

    def save_entry(self, entry):
        self.populate_obj(entry)
        entry.generate_slug()
        return entry


class CommentForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired()])
    url = StringField('URL', validators=[Optional(), URL()])
    body = TextAreaField('Comment', validators=[DataRequired(), Length(min=10, max=3000)])
    entry_id = HiddenField(validators=[DataRequired()])

    def validate(self):
        if not super(CommentForm, self).validate():
            return False
        
        # Ensure that entry_id maps to a public Entry.
        entry = Entry.query.filter(
            (Entry.status == Entry.STATUS_PUBLIC) &
            (Entry.id == self.entry_id.data)).first()
        if not entry:
            return False

        return True



