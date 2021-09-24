from pathlib import Path

from flask import Flask, render_template, request

app = Flask(__name__, template_folder='flask-app/templates')

data_file_path = Path('/mnt/data/data_file.txt')

if not Path.exists(data_file_path):
    Path.mkdir(data_file_path.parent, exist_ok=True)
    with open(data_file_path, 'w+') as data_file:
        data_file.write('Here lies data:\n\n')


@app.route('/', methods=['GET', 'POST'])
def home():  # put application's code here
    if request.method == 'POST':
        new_data = request.form['new_data']

        with open(data_file_path, "a") as datafile:
            datafile.write(f'{new_data}\n')
        return render_template('home.html')
    else:
        return render_template('home.html')


@app.route('/stored_data', methods=['GET'])
def stored_data():
    with open(data_file_path, "r") as datafile:
        data = datafile.readlines()
    return render_template('stored_data.html', methods=['GET'], data=data)


if __name__ == '__main__':
    app.run()
