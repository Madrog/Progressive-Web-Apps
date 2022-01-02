import click
# from flask import current_app as app
from flask_cli import FlaskGroup
from main import *


@click.group(cls=FlaskGroup)
def cli():
    """Management interface for the blog"""
    pass


@cli.command("init")
def init():
    """Run app initialization routes"""
    click.echo(f"{app.name} initialized for {app.config['ENV']} environment")



if __name__ == '__main__':
    app.run()