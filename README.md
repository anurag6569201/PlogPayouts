# PlogPayouts  

*GDSC Soltuion Challenge 2024*


Our product (**website** + **app**) provides a solution to ever-growing concern about a **healthy environement** and **cleanliness** altogether, especially in places where there is **scarcity** of any **garbage collectors**.

Our solution integrates an every days activity which keeps one fit  jogging while contributing little bit to a healthy environement by **collecting litter** from manageable **trash sites**, leading to our solution - *PlogPayouts*.

![Logo](https://firebasestorage.googleapis.com/v0/b/fashionx-ebe6c.appspot.com/o/temp%2Flogo_1.png?alt=media&token=13098b57-3f6a-4dc3-9d1e-2bd35613b814)


![Logo](https://firebasestorage.googleapis.com/v0/b/fashionx-ebe6c.appspot.com/o/temp%2Flogo_2.png?alt=media&token=a45c4618-9b64-45e3-8491-896d06329af1)



## Demo

#### Website (Preview of Features)

[Website](https://firebasestorage.googleapis.com/v0/b/fashionx-ebe6c.appspot.com/o/temps%2FDocument%20-%20Google%20Chrome%202024-02-13%2001-28-28.mp4?alt=media&token=f9f162b8-9bd9-41a1-ad81-fcfbdd687942)


###
#### App

[App](https://firebasestorage.googleapis.com/v0/b/fashionx-ebe6c.appspot.com/o/temp%2Fapp_gif.gif?alt=media&token=c96f7551-af08-463e-9ba3-18b27ccfb755)


###

### YouTube

[Youtube Video Link](https://youtu.be/fU7S5YPEcQk)



## Tech Stack

**Client:** Flutter, HTML, CSS JavaScript, Bootstrap

**Backend:** Flask, Python , Keras, OpenCV, YOLOv8

**Storage:** Django, Firebase Firestore, Realtime Database, Storage

**Other Tools:** GCP APIs, Mapbox, Render, Docker

## Features

1. **Categorization of Trash w/ Deep Learning**

Used Transfer Learning on VGG19 model alongwith a custom dataset combined with an open-sourced and hand labelled ones.

2. **Reward System**

-> Earn points for each **category** and **count** (using YOLOv8) of litter collected during plogging and once the garbage collected has been verified by the Garbage Collector on-site (so the garbage collected does reach to a factory through the worker), points are sent.

-> Redeem points in the 'Store' for gift cards.

-> The categorization of garbage is intended for smoothing out the process of post garbage collected by already organizing the garbage as much as possible.




3. **Map Location**

Genetic Algorithm automatically finds the best route for the locations of trash sites marked as 'Favourite' so as to cater to their jogging times (upto 3 max).

4. **Blog System**

Share plogging experiences, environmental tips, and success stories through the integrated blog system, brining in the community together and breaking the social stigma how 'garbage collector' are perceived.



## Requirements


Please install the following requirements before proceeding with the next steps
#### Server

```bash
Docker
```
    




#### App


```bash
Android Studio
Flutter SDK
```
    
    
1. Ensure that you are able to run Flutter apps locally by  installing the following packages
2. Run the following command to ensure your system meets the requirements to run the app. All requirements must be met to run the app.

        flutter doctor 


3. **Map Location:**
   - AI algorithms analyze user data to predict areas with higher litter accumulation.

4. **Blog System:**
   - Share plogging achievements, tips, and environmental insights through the integrated blog system.




## Run Locally

- HTML, CSS, JavaScript,Bootstrap for the frontend.
- Django and Python for the backend.
- TensorFlow and PyTorch for image recognition and classification.



### Website

Pull the server image from DockerHub

```bash
  docker pull yuvrajsingh9886/plogpayouts-server-gunicorn-flask:v1.0
```

Run the server image

```bash
  docker container run -d -p 8080:8080 yuvrajsingh9886/plogpayouts-server-gunicorn-flask:v1.0
```

### Website

Clone the project

```bash
  git clone https://github.com/anurag6569201/PlogPayouts.git
```

Go to the project directory

```bash
  cd webapp
```

Create a virtual environment

```bash
  virtualenv envname
```


Install dependencies

```bash
  pip install -r requirements.txt
```

Activate virtualenv

```bash
  workon envname
```

Run the website Locally

```bash
  python manage.py runserver
```







### App

1. Run the following commands to download all required dependancies.

```bash
flutter clean
flutter pub get
```

2. Run the following command to run the app on emulator/real device

```bash
flutter run
```

## License

[MIT](https://choosealicense.com/licenses/mit/)


## Authors


- [@AnuragSingh](https://github.com/anurag6569201)
- [@YuvrajSingh](https://github.com/YuvrajSingh-mist)


