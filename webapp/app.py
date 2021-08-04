from flask import Flask, render_template

app = Flask(__name__, template_folder='flask-app/templates')


@app.route('/')
def hello_world():  # put application's code here
    return render_template('home.html', methods=['GET'])


if __name__ == '__main__':
    app.run()
