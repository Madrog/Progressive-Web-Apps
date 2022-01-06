from werkzeug.datastructures import D
import wtforms

from app.models import Entry

class EntryForm(wtforms.Form):
    title = wtforms.StringField('Title')
    body = wtforms.TextAreaField('body')
    status = wtforms.SelectField(
        'Entry status',
        choices=(
            (Entry.STATUS_PUBLIC, 'Public'),
            (Entry.STATUS_DRAFT, 'Draft')),
            coerce=int)

    def save_entry(self, entry):
        self.populate_obj(entry)
        entry.generate_slug()
        return entry