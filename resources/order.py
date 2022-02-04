import time

from flask import make_response, render_template
from flask_restful import Resource

from resources import api


class OAuthApi(Resource):

    def get(self):
        time.sleep(1)  # some query to the database
        r = make_response(
            render_template('index.html')
        )
        r.headers.set('Content-Type', "text/html")
        return r


api.add_resource(OAuthApi, "/order")
