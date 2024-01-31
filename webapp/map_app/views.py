from userauths.models import Verify_Contribution
from userauths.forms import Verify_ContributionForm
from userauths.models import UserProfile
from userauths.models import User

from django.shortcuts import render,redirect,HttpResponse
import folium
import requests

import requests
from django.db import IntegrityError
from map_app.models import PredictionModel

import random


def draw_path_on_map(coordinates):
    m = folium.Map(location=coordinates[0], zoom_start=14)
    folium.Marker(location=coordinates[0], popup='Point 1', icon=folium.Icon(color='blue')).add_to(m)
    folium.Marker(location=coordinates[1], popup='Point 2', icon=folium.Icon(color='green')).add_to(m)
    folium.Marker(location=coordinates[2], popup='Point 3', icon=folium.Icon(color='red')).add_to(m)
    folium.Marker(location=coordinates[3], popup='Point 4', icon=folium.Icon(color='purple')).add_to(m)

    folium.PolyLine(locations=coordinates, color='blue').add_to(m)

    map_html = m.get_root().render()
    return map_html

def show_path(request):
    if request.method == 'POST':
        # Get coordinates from the form
        lat1 = float(request.POST.get('lat1', 0))
        lon1 = float(request.POST.get('lon1', 0))
        lat2 = float(request.POST.get('lat2', 0))
        lon2 = float(request.POST.get('lon2', 0))
        lat3 = float(request.POST.get('lat3', 0))
        lon3 = float(request.POST.get('lon3', 0))
        lat4 = float(request.POST.get('lat4', 0))
        lon4 = float(request.POST.get('lon4', 0))

        coordinates = [(lat1, lon1), (lat2, lon2), (lat3, lon3), (lat4, lon4)]
        map_html = draw_path_on_map(coordinates)
        return render(request, 'map_app/show_path.html', {'map_html': map_html})
    
    return render(request, 'map_app/show_path.html')

from django.shortcuts import render
import folium
from userauths.models import Contribution

def draw_contributions_on_map(contributions):
    m = folium.Map(location=[contributions[0].latitude, contributions[0].longitude], zoom_start=14)

    for contribution in contributions:
        # Create a marker with a popup for each contribution
        popup_html = f'<img src="{contribution.image.url}" alt="Contribution Image" style="max-width: 200px;">'
        folium.Marker(location=[contribution.latitude, contribution.longitude], popup=folium.Popup(html=popup_html, max_width=300), icon=folium.Icon(color='blue')).add_to(m)

    map_html = m.get_root().render()
    return map_html

def show_contributions(request):
    user_profile = UserProfile.objects.get(user=request.user)
    contributions = Contribution.objects.all()

    if contributions:
        map_html = draw_contributions_on_map(contributions)
        return render(request, 'map_app/show_contributions.html', {'map_html': map_html,"user_profile": user_profile})
    else:
        return render(request, 'map_app/show_contributions.html', {'error_message': 'No contributions available.'})
    
    
def show_full(request):
    user_profile = UserProfile.objects.get(user=request.user)
    contributions = Contribution.objects.all()

    if contributions:
        map_html = draw_contributions_on_map(contributions)
        return render(request, 'map_app/show_full.html', {'map_html': map_html, "user_profile": user_profile})
    else:
        return render(request, 'map_app/show_full.html', {'error_message': 'No contributions available.'})
    
def verify_contributions(request):
    api_call_url = None

    if request.method == 'POST':
        form = Verify_ContributionForm(request.POST, request.FILES)
        if form.is_valid():
            contribution = form.save()
            image_url = request.build_absolute_uri(contribution.Verify_image.url)
            api_call_url = f"http://34.28.156.229:8080/garbage?query={image_url}"
            response = requests.get(api_call_url)
            if response.status_code == 200:
                content = response.json()
                try:
                    
                    # calculating points

                    score_of_image = 0

                    if content['prediction'] == "plastic":
                        score_of_image = 20 * content['count']

                    elif content['prediction'] == "cardboard":
                        score_of_image = 20 * content['count']

                    elif content['prediction'] == "glass":
                        score_of_image = 50 * content['count']

                    elif content['prediction'] == "metal":
                        score_of_image = 20 * content['count']

                    elif content['prediction'] == "trash":
                        score_of_image = random.randint(20, 50) * content['count']
                    
                    prediction_instance = PredictionModel.objects.create(
                        count=content['count'],
                        prediction=content['prediction'],
                        status=content['status'],
                        score_of_image=score_of_image
                    )

                    print(f"Data saved: {prediction_instance}")
                    return redirect("core:redeem")
                except IntegrityError:
                    print("Data already exists in the database.")
            else:
                print(f"Failed to retrieve content. Status code: {response.status_code}")
    else:
        form = Verify_ContributionForm()

    user_profile = UserProfile.objects.get(user=request.user)
    context = {
        'user_profile': user_profile,
        'verify_contribution_form': form,
    }
    return render(request, 'map_app/verify_contributions.html', context)