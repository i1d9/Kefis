import os

import joblib


def load_model():
    path = os.path.abspath('lib/kefis/model/model.pkl')
    return joblib.load(path)

def predict_model(args):
    model = load_model()
    return model.predict([args])
    