from flask import Flask,request

flask_object = Flask(__name__)


@flask_object.route('/', methods=['POST'])
def index():
    data = request.json()
    if data:
        print(data)
        return 'Done'
    else:
        return 'No data found'


if __name__ == "__main__":
    flask_object.run(debug=True)
