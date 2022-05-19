'''
SUMMARY
We need to create the same custom class we used during the model creation.
The functions from that class are used in the model and pickled. Therefore,
the model needs to have access to the class during the scoring also.

Access to other 'sklearn' modules are provided automatically so importing
them here not necessary.
''' 

# === PACKAGES === #

from flask import Flask, jsonify, request
from flask_restful import Resource, Api, reqparse

import pandas as pd
import numpy as np
import pickle

# create API
app = Flask(__name__) # create Flask instance
api = Api(app) # create Api object using Flask instance

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
class Scoring(Resource):
    
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
    
# assign endpoint to Scoring class
api.add_resource(Scoring, '/scoring')
        
# define app run trigger and connection parameters
if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=5555)