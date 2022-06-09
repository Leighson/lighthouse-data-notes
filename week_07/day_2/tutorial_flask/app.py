from flask import Flask
app = Flask(__name__)

# %% set up instance of hello_world triggered instead by app.route('/')
@app.route('/')
def hello_world():
    return 'Hello, World!'

# when the app is instanced, run it
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555)