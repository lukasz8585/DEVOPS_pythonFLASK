from flask import Blueprint, Flask, make_response
from flask_restful import Api


def create_app():
    app = Flask("ISADevOpsIntro")
    with app.app_context():
        app.register_blueprint(status_blueprint)
        app.register_blueprint(api_blueprint)
    return app


status_blueprint = Blueprint("status", __name__, url_prefix="/")


@status_blueprint.route('/')
def status():
    return make_response({"status": "OK"}, 200)


api_blueprint = Blueprint("api", __name__, url_prefix='/api')
api = Api(api_blueprint)

from . import order      # noqa
