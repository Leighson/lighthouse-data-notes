from flask import Flask
from flask_restful import Resource, Api, request
import pickle
import pandas as pd

app = Flask(__name__)
api = Api(app)

# create custom class
class RowFeats():
    def __init__(self, feats):
        self.feats = feats
    
    def fit(self, x, y=None):
        pass
    
    def transform(self, x, y=None):
        return x[self.feats]
    
    def fit_transform(self, x, y=None):
        self.fit(x)
        return self.transform(x)
    
model = pickle.load(open('model.pk', 'rb'))

# === POST === #
# create an endpoint where we can communicate with our ML model

# request class to retrieve model results
class Model(Resource):
    
    def post(self):
        
        # define post request and unpack into dataframe
        json_data = request.get_json()
        df = pd.DataFrame(
            json_data.values(),
            index=json_data.keys()).transpose()
        
        # define response given the model has already been trained
        res = model.predict_proba(df)
        
        # convert to list; numpy array will return an error
        return res.tolist()

api.add_resource(Model, '/model')

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5555)