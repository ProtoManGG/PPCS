from flask import Flask

flask_object = Flask(__name__)


@flask_object.route('/', methods=['GET'])
def index():
    return 'hello'


if __name__ == "__main__":
    flask_object.run(debug=True)
