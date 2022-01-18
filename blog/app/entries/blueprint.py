import os

from flask import Blueprint, flash, render_template, request, redirect, url_for, current_app as app
from werkzeug.utils import secure_filename
from app import db
from app.helpers import object_list
from app.models import Entry, Tag
from app.entries.forms import EntryForm, ImageForm
 

entries = Blueprint('entries', __name__, template_folder='templates')


def entry_list(template, query, **context):
    valid_statuses = (Entry.STATUS_PUBLIC, Entry.STATUS_DRAFT)
    query = query.filter(Entry.status.in_(valid_statuses))
    if request.args.get('q'):
        search = request.args['q']
        query = query.filter(
            (Entry.body.contains(search)) | 
            (Entry.title.contains(search)))

    return object_list(template, query, **context)


def get_entry_or_404(slug):
    valid_statuses = (Entry.STATUS_PUBLIC, Entry.STATUS_DRAFT) 
    return (Entry.query.filter((Entry.slug==slug) & (Entry.status.in_(valid_statuses))).first_or_404())


@entries.route('/')
def index():
    entries = Entry.query.order_by(Entry.created_timestamp.desc())
    return entry_list('entries/index.html', entries)


@entries.route('/tags/')
def tag_index():
    tags = Tag.query.order_by(Tag.name)
    return object_list('entries/tag_index.html', tags)


@entries.route('/tags/<slug>/')
def tag_detail(slug):
    tag =  Tag.query.filter(Tag.slug == slug).first_or_404()
    entries = tag.entries.order_by(Entry.created_timestamp.desc())
    return entry_list('entries/tag_detail.html', entries, tag=tag)


@entries.route('/create/', methods=['GET', 'POST'])
def create():
    if request.method == 'POST':
        form = EntryForm(request.form)
        if form.validate():
            entry = form.save_entry(Entry())
            db.session.add(entry)
            db.session.commit()
            flash('Entry "%s" created successfully' % entry.title, 'success')
            return redirect(url_for('entries.detail', slug=entry.slug))
    else:
        form = EntryForm()  

    return render_template('entries/create.html', form=form)


@entries.route('/<slug>/')
def detail(slug):
    entry = get_entry_or_404(slug)
    return render_template('entries/detail.html', entry=entry)


@entries.route('/<slug>/edit/', methods=['GET', 'POST'])
def edit(slug):
    entry = get_entry_or_404(slug)
    form = EntryForm()
    if form.validate_on_submit():
        entry.title = form.title.data
        entry.body = form.body.data
        entry.status = form.status.data
        entry.tags = form.tags.data
        entry = form.save_entry(entry)
        db.session.commit()
        flash('Entry "%s" has been saved.' % entry.title, 'success')
        return redirect(url_for('entries.detail', slug=entry.slug))
    elif request.method == 'GET':
        form.title.data = entry.title
        form.body.data = entry.body
        form.status.data = entry.status
        form.tags.data = entry.tags
    return render_template('entries/edit.html', entry=entry, form=form)


@entries.route('/<slug>/delete/', methods=['GET', 'POST'])
def delete(slug):
    entry = get_entry_or_404(slug)
    if request.method == 'POST':
        entry.status = Entry.STATUS_DELETED
        db.session.commit()
        flash('Entry "%s" has been deleted.' % entry.title, 'success')
        return redirect(url_for('entries.index'))
    return render_template('entries/delete.html', entry=entry)


@entries.route('/image-upload/', methods=['GET', 'POST'])
def image_upload():
    if request.method == 'POST':
        form = ImageForm(request.form)
        if form.validate():
            image_file = request.files['file']
            filename = os.path.join(app.config['IMAGES_DIR'], secure_filename(image_file.filename))
            image_file.save(filename)
            flash('Saved %s' % os.path.basename(filename), 'success')
            return redirect(url_for('entries.index'))
    else:
        form = ImageForm()

    return render_template('entries/image_upload.html', form=form)
    