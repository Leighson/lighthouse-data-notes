'''
CALCULATOR
==========
Take two numbers as arguments and apply the
following operations:
- addition
- subtraction
- multiply
- divide

Then return the result.
'''


# === PACKAGES === #

from flask import Flask
from flask_restful import Resource, Api, reqparse


# === FLASK === #

# instantiate Flask object
app = Flask(__name__)

# define Flask object app in an Api wrapper
api = Api(app)


# === OPERATIONS === #

class Add(Resource):
    
    def get(self):
        
        parser = reqparse.RequestParser()
        parser.add_argument('x', type=int)
        parser.add_argument('y', type=int)
        
        x = parser.parse_args().get('x')
        y = parser.parse_args().get('y')
        
        num = x + y
        
        return num

class Subtract(Resource):
    
    def get(self):
        
        parser = reqparse.RequestParser()
        parser.add_argument('x', type=int)
        parser.add_argument('y', type=int)
        
        x = parser.parse_args().get('x')
        y = parser.parse_args().get('y')
        
        num = abs(x -y)
        
        return num
    
class Multiply(Resource):
    
    def get(self):
        
        parser = reqparse.RequestParser()
        parser.add_argument('x', type=int)
        parser.add_argument('y', type=int)
        
        x = parser.parse_args().get('x')
        y = parser.parse_args().get('y')
        
        num = x * y
        
        return num
    
class Divide(Resource):
    
    def get(self):
        
        parser = reqparse.RequestParser()
        parser.add_argument('x', type=int)
        parser.add_argument('y', type=int)
        
        x = parser.parse_args().get('x')
        y = parser.parse_args().get('y')
        
        if x > y:
            num = x / y
        else:
            num = y /x
            
        return num


# === ENDPOINTS === #

# assign endpoints to each resource
api.add_resource(Add, '/add')
api.add_resource(Subtract, '/subtract')
api.add_resource(Multiply, '/multiply')
api.add_resource(Divide, '/divide')


# === RUN === #

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555)