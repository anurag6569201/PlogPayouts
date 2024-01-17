from flask import Flask, jsonify, request, render_template
import requests, pickle

import tensorflow as tf
import keras
from tensorflow.keras.layers import Input, Dense, Conv2D
from tensorflow.keras import Sequential
from keras.preprocessing.image import ImageDataGenerator, load_img, img_to_array, array_to_img
from tensorflow.keras.models import Model
from tensorflow.keras.layers import UpSampling2D, MaxPooling2D, Flatten
import cv2
import os
import random
from tqdm import tqdm
import numpy as np
from keras.preprocessing import image
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import BatchNormalization
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.layers import Activation
from tensorflow.keras.layers import Dropout
from tensorflow.keras.layers import concatenate
from tensorflow.keras.layers import BatchNormalization
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from tensorflow.keras.applications.vgg19 import VGG19
from keras.applications.vgg19 import preprocess_input

import json
import googlemaps
from datetime import datetime


import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)


db = firestore.client()

data_locations = []

for i in range(3):
    db_ref = db.collection('locations').document('L' + str(i)).get();
#     data_locations.append((db_ref.id, db_ref.title, db_ref.coordinates))
# print(data_locations)
    print(db_ref.id)


app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/mask', methods=['GET', 'POST'])
def predict_mask():
    flag = True
    # if request.method == 'POST':
    #    # check if the post request has the file part
    #    if 'file' not in request.files:
    #       return "something went wrong 1"
    #
    #    user_file = request.files['file']
    #    temp = request.files['file']
    #    if user_file.filename == '':
    #        return "file name not found ..."
    #
    #    else:
    #        # path = os.path.join(os.getcwd(), 'static/mask', user_file.filename)
    #        # user_file.save(path)
    # filename = request.args.get('query')
    full_path = request.full_path

    # Extract the 'query' parameter from the full path
    query_parameter = full_path.split('query=')[1]
    print("Filename is : ", query_parameter)
    count= 0
    with open('static/mask/mask_{}.jpg'.format(count), 'wb') as f:
        data = requests.get(query_parameter)
        f.write(data.content)
    # filename = 'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/user-images%2F2cznu8kGbtbbCZ3s22c9E1AnqG92.jpg?alt=media&token=91b2b18f-826a-4d15-bdf6-e940a6d25ec7'
    
    classes = identifyImage_mask(os.path.join('static/mask', 'mask_{}.jpg'.format(count)))
    print(classes)

    if classes[0] < 0.5:
        flag = False
    return jsonify({
        "status": "success",
        "prediction": int(flag),
        # "confidence": str(classes[0][0][2]),
        # "upload_time": datetime.now()
    })


@app.route('/gloves', methods=['GET', 'POST'])
def predict_gloves():
    flag = True
    # if request.method == 'POST':
    #    # check if the post request has the file part
    #    if 'file' not in request.files:
    #       return "something went wrong 1"
    #
    #    user_file = request.files['file']
    #    temp = request.files['file']
    #    if user_file.filename == '':
    #        return "file name not found ..."
    #
    #    else:
    #        # path = os.path.join(os.getcwd(), 'static/mask', user_file.filename)
    #        # user_file.save(path)
    # filename = request.args.get('query')
    full_path = request.full_path

    # Extract the 'query' parameter from the full path
    query_parameter = full_path.split('query=')[1]
    print("Filename is : ", query_parameter)
    count = 0
    with open('static/gloves/gloves_{}.jpg'.format(count), 'wb') as f:
        data = requests.get(query_parameter)
        f.write(data.content)
    # filename = 'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/user-images%2F2cznu8kGbtbbCZ3s22c9E1AnqG92.jpg?alt=media&token=91b2b18f-826a-4d15-bdf6-e940a6d25ec7'

    classes = identifyImage_gloves(os.path.join('static/gloves', 'gloves_{}.jpg'.format(count)))
    print(classes)

    if classes[0] < 0.5:
        flag = False
    return jsonify({
        "status": "success",
        "prediction": int(flag),
        # "confidence": str(classes[0][0][2]),
        # "upload_time": datetime.now()
    })

def identifyImage_mask(img_path):
    
    image = load_img(img_path, target_size=(224, 224, 3))
    img_array = img_to_array(image)
    img_array = preprocess_input(img_array)
    img_array = np.expand_dims(img_array, axis=0)
    model = tf.keras.models.load_model('models/mask_detector.keras')
    pred = model.predict(img_array)
    return pred


def identifyImage_gloves(img_path):
    
    image = load_img(img_path, target_size=(224, 224, 3))
    img_array = img_to_array(image)
    img_array = preprocess_input(img_array)
    img_array = np.expand_dims(img_array, axis=0)
    model = tf.keras.models.load_model('models/gloves_detector-2.keras')
    pred = model.predict(img_array)
    return pred



if __name__ == '__main__':
    app.run(debug=False)









