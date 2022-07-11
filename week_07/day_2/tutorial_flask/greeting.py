# import Flask and jsonify
from flask import Flask, jsonify

# import Resource, API, and reqparser
from flask_restful import Resource, Api, reqparse

# %% create an application
app = Flask(__name__)

# %% create an API from the application
api = Api(app)

# now that the API has been created, we need to add an endpoint
# %% create a new class that inherits properties from the 'Resources' class
class Greet(Resource):
    
    def get(self):
        # create request parser
        parser = reqparse.RequestParser()
        
        # create argument 'name'
        parser.add_argument('name', type=str)
        
        # parse 'name'
        name = parser.parse_args().get('name')
        
        if name:
            greeting = f'Hello {name}!'
        else:
            greeting = 'Hello person without name!'
        
        # make json from greeting string
        return jsonify(greeting=greeting)
    
# the class`Greet` contains only one method - _get_
# inside the _get_ method, we initialize RequestParser()
    # which allows us to parse optional arguments
# there is only one optional argument _name_ as a string type
# in _name_, we store an argument value that was passed by calling our API
# if the user doesn't pass a _name_, the value of the variable is `NULL`
    # which will result in a different message being returned

# %% assign endpoint using `Greet` class
api.add_resource(Greet, '/greet')

# %% lastly, create an application run when the file is called directly
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)