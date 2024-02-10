from copy import copy
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


from ultralytics import YOLO
# from autodistill_yolov8 import YOLOv8

import json
import googlemaps
from datetime import datetime


MAPBOX_API_KEY = 'pk.eyJ1IjoieXV2cmFqc2luZ2gtbWlzdCIsImEiOiJjbHJoa2l6cG0wcTNlMnFwOWlrNDl5cDZ6In0.5mYZ0IGOQEub0fAOgML9qg'
    
    

from geopy.distance import geodesic as GD
from geopy.geocoders import Nominatim
geolocator = Nominatim(user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")


import firebase_admin
import firebase_admin
from firebase_admin import db, credentials

cred = credentials.Certificate("serviceAccountKeyRealtimeDatabase.json")

firebase_admin.initialize_app(cred, {'databaseURL': 'https://solution-challenge-app-409f6-default-rtdb.firebaseio.com/'})
# db = firestore.client()

# data_locations = []

# for i in range(3):
#     db_ref = db.collection('locations').document('L' + str(i)).get()
#     data_locations.append((db_ref._data['id'], db_ref._data['title'], db_ref._data['coordinates']))
# print(data_locations)
    # print(db_ref._data)


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

@app.route('/locations', methods=['GET', 'POST'])
def location_data():
    

    full_path = request.full_path
    print(full_path)
    query_parameter = full_path.split('query=')[1]
    print(query_parameter)
    
    # print(f'/chosen-locations')
    print(f'https://solution-challenge-app-409f6-default-rtdb.firebaseio.com/solution-challenge/{query_parameter}/chosen-locations/')
    ref = db.reference(f'solution-challenge/{query_parameter}/chosen-locations/')
    data = ref.get()
    decoded = data.values()
    city_ids = []
    current_location = []
    # print(len(decoded))
    # print(decoded)
    dict_places = {}
    location = ""
    print(decoded)
    for i in decoded:
        # print(i)
        city_ids.append(int(i['Id']))
        dict_places[int(i['Id'])] = (i['latitude'], i['longitude'])

        location = i['current_location']
      
    current_location.append(location)
    location = geolocator.geocode(current_location[0])
    dict_places[0] = (location.latitude, location.longitude)
    print(dict_places)
    print(city_ids)
    planned_route = route_optimize(dict_places, city_names=city_ids)
    
    return planned_route

def cal_dist(place1, place2):
    return GD(place1,place2).km

def calculate_duration(start_point, end_point, profile='walking'):
        base_url = f'https://api.mapbox.com/directions/v5/mapbox/{profile}'
        access_token = f'access_token={MAPBOX_API_KEY}'
        
        coordinates = f'{start_point[0]},{start_point[1]};{end_point[0]},{end_point[1]}'
        
       
        url = f'{base_url}/{coordinates}?{access_token}'
        print(url)
        response = requests.get(url)
        
        if response.status_code == 200:
            data = response.json()
            
            print(data)
            duration = data['routes'][0]['duration']
            
    
            duration = duration / 3600

@app.route('/timeDistance', methods=['GET', 'POST'])
def time_and_distance() :
    full_path = request.full_path
    print(full_path)
    query_parameter = full_path.split('query=')[1]
    print(query_parameter)
    
    # print(f'/chosen-locations')
    print(f'https://solution-challenge-app-409f6-default-rtdb.firebaseio.com/solution-challenge/{query_parameter}/chosen-locations/')
    ref_current_location = db.reference(f'solution-challenge/{query_parameter}/current-location/')
    data_curr_location = ref_current_location.get()
    
    ref = db.reference(f'solution-challenge/{query_parameter}')
    data = ref.get()
    
    decoded_curr_location = data_curr_location.values()
    decoded = data
    # city_ids = []
    current_location = []
    # print(len(decoded))
    # print(decoded)
    dict_places = {}
    location = ""
    # print(decoded_curr_location)
    # print(decoded.keys())
    for i in decoded_curr_location:
        # print(i)
        # city_ids.append(int(i['Id']))
        # dict_places[int(i['Id'])] = (i['latitude'], i['longitude'])
     
            location = i['current_location']
      
    for i in decoded.keys():
        # print(i)
        # city_ids.append(int(i['Id']))
        # print(type(decoded.keys()))
        # for j in decoded.keys() :
        if i not in ['chosen-locations', 'collected-garbage', 'current-location']:
            dict_places[int(decoded[i]['Id'])] = (decoded[i]['latitude'], decoded[i]['longitude'])
           
                # print(decoded[i])
                # break
    # print("location is ", location)
    # current_location.append(location)
    # location = geolocator.geocode(current_location[0])
    dict_places[0] = (location[0], location[1])
    print(dict_places)
    # print(city_ids)
    # print(dict_places)
    data = []
    for i in range(len(dict_places)):
        if(i != 0):
            data.append((cal_dist_flask(dict_places[i], dict_places[0])))
    # planned_route = route_optimize(dict_places, city_names=city_ids)
    

    
        
        
    return jsonify({
        "status": "success",
        "distance": data[0],
        # "duration": duration
        # "confidence": str(classes[0][0][2]),
        # "upload_time": datetime.now()
    })


def cal_dist_flask(place1, place2):
    return GD(place1,place2).km


def route_optimize(dict_places, city_names, start=0):
    # print("Places are: ",dict_places)
    def create_guess(cities, start):

        guess = copy(cities)

        np.random.shuffle(guess)
        guess.append(start)
        guess.insert(0,start)
        # print("guess is", guess)
        return list(guess)

    create_guess(city_names, start)



    def create_generation(cities, population=100):

        generation = [create_guess(cities, start) for _ in range(population)]
        # print("Generation is ", generation)
        return generation

    test_generation = create_generation(city_names, population=10)
    # print(test_generation)

    def fitness_score(guess):

        score = 0
        # print("Guess in fitness is:",guess)
        for ix, city_id in enumerate(guess[:-1]):
            # print(city_id)
            score += cal_dist(dict_places[city_id], dict_places[guess[ix]])
        return score

    def check_fitness(guesses):
    
        fitness_indicator = []
        for guess in guesses:
            fitness_indicator.append((guess, fitness_score(guess)))
        return fitness_indicator

    # print(check_fitness(test_generation))



    def get_breeders_from_generation(guesses, take_best_N=10, take_random_N=5, verbose=False, mutation_rate=0.1):

        fit_scores = check_fitness(guesses)
        sorted_guesses = sorted(fit_scores, key=lambda x: x[1])
        new_generation = [x[0] for x in sorted_guesses[:take_best_N]]
        best_guess = new_generation[0]
        
        if verbose:
        
            print(best_guess)
        
    
        for _ in range(take_random_N):
            ix = np.random.randint(len(guesses))
            new_generation.append(guesses[int(ix)])
            

        
        np.random.shuffle(new_generation)
        return new_generation, best_guess

    def make_child(parent1, parent2):

        list_of_ids_for_parent1 = list(np.random.choice(parent1, replace=False, size=len(parent1)))
        child = [-99 for _ in parent1]
        
        for ix in list_of_ids_for_parent1:
            # print("List is: ", list_of_ids_for_parent1)
            # ix = int(ix)
            child[ix] = parent1[ix]
        for ix, gene in enumerate(child):
            # ix = int(ix)
            if gene == -99:
                for gene2 in parent2:
                    if gene2 not in child:
                        child[ix] = gene2
                        break
        child[-1] = child[0]
        return child

    def make_children(old_generation, children_per_couple=1):

        mid_point = len(old_generation)//2
        next_generation = [] 
        
        for ix, parent in enumerate(old_generation[:mid_point]):
            for _ in range(children_per_couple):
                next_generation.append(make_child(parent, old_generation[-ix-1]))
        print("next generation is ", next_generation)
        return next_generation


    current_generation = create_generation(city_names,population=300)
    print_every_n_generations = 5

    for i in range(100):
        if not i % print_every_n_generations:
            # print("Generation %i: "%i, end='')
            # print(len(current_generation))
            is_verbose = True
        else:
            is_verbose = False
        is_verbose=False
        breeders, best_guess = get_breeders_from_generation(current_generation, 
                                                            take_best_N=250, take_random_N=100, 
                                                            verbose=is_verbose)
        # print("breeders are", breeders)
        current_generation = make_children(breeders, children_per_couple=3)


    def evolve_to_solve(current_generation, max_generations, take_best_N, take_random_N,
                        mutation_rate, children_per_couple, print_every_n_generations, verbose=False):

        fitness_tracking = []
        for i in range(max_generations):
            if verbose and not i % print_every_n_generations and i > 0:
                print("Generation %i: "%i, end='')
                print(len(current_generation))
                print("Current Best Score: ", fitness_tracking[-1])
                is_verbose = True
            else:
                is_verbose = False
            is_verbose=False
            breeders, best_guess = get_breeders_from_generation(current_generation, 
                                                                take_best_N=take_best_N, take_random_N=take_random_N, 
                                                                verbose=is_verbose, mutation_rate=mutation_rate)
            fitness_tracking.append(fitness_score(best_guess))
            current_generation = make_children(breeders, children_per_couple=children_per_couple)
        
        return fitness_tracking, best_guess

    current_generation = create_generation(city_names,population=100)
    print("Current students ", current_generation)
    fitness_tracking, best_guess = evolve_to_solve(current_generation, 100, 150, 70, 0.5, 3, 5, verbose=False)

    print("Route is: ", best_guess)
    res = []
    # res.append(dict_places[0])
    for data in best_guess:
        for i in dict_places.keys():
            if i == data:
            # if i == data['Id']:
                # res.append(dict_places['latitude'], data['longitude'])
                # break
                print(dict_places[i])
                res.append(dict_places[i])
                break
    print(res)
    return res


#Needs re-training
@app.route('/garbage', methods=['GET', 'POST'])
def identifyGarbage():
    
    full_path = request.full_path

    # Extract the 'query' parameter from the full path
    query_parameter = full_path.split('query=')[1]
    print("Filename is : ", query_parameter)
    count= 0
    with open('static/garbage/garbage_{}.jpg'.format(count), 'wb') as f:
        data = requests.get(query_parameter)
        f.write(data.content)
    # filename = 'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/user-images%2F2cznu8kGbtbbCZ3s22c9E1AnqG92.jpg?alt=media&token=91b2b18f-826a-4d15-bdf6-e940a6d25ec7'
    
    classes = identifyImage_garbage(os.path.join('static/garbage', 'garbage_{}.jpg'.format(count)))
    print(classes)

    # if classes[0] < 0.5:
    #     flag = False
    cnt = counting(os.path.join('static/garbage', 'garbage_{}.jpg'.format(count)))
    print(cnt)
    return jsonify({
        "status": "success",
        "prediction": classes,
        "count" : cnt
        # "confidence": str(classes[0][0][2]),
        # "upload_time": datetime.now()
    })
    
#Needs re-training
def counting(img_path):
    print(img_path)
    model = YOLO('yolov8m.pt')
    results = model.predict(img_path)
    
    names = model.names

    car_id = list(names)[list(names.values()).index('car')]

    predicted_indices = results[0].boxes.cls.tolist()
    # predicted_class_names = [list(names.keys())[list(names.values()).index(idx)] for idx in predicted_indices]
    
    # for i in predicted_class_names:
    #  countings += results[0].boxes.cls.tolist().count(predicted_indices)
    # print(car_id)
    # print(results[0])
    # print(results[0].boxes.cls.tolist())
    return len(predicted_indices)


def identifyImage_garbage(img_path):
    
    # //The dictionary
    dict_decode = {'cardboard': 0, 'glass': 1, 'metal': 2, 'paper': 3, 'plastic': 4, 'trash': 5} 
    
    image = load_img(img_path, target_size=(224, 224, 3))
    img_array = img_to_array(image)
    img_array = preprocess_input(img_array)
    img_array = np.expand_dims(img_array, axis=0)
    model = tf.keras.models.load_model('models/Litter_Classiication.keras')
    pred = model.predict(img_array)
    print(pred)
    pred = np.argmax(pred, axis=1)
    print(pred)
    res = ""
    # print(dict_decode.values())
    for i in dict_decode: 
        if(pred == dict_decode[i]): res = i
    print("res is: ", res)
    return res

 
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
    app.run(host='0.0.0.0', port=8080)









