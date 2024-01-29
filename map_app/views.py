from userauths.forms import Verify_ContributionForm
from userauths.models import UserProfile
from django.shortcuts import render,redirect
import folium

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
    if request.method == 'POST':
        form = Verify_ContributionForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('core:index')
    else:
        form = Verify_ContributionForm()
    user_profile = UserProfile.objects.get(user=request.user)
    context = {
        "user_profile": user_profile,
        'verify_contribution_form': form,
    }
    return render(request, 'map_app/verify_contributions.html',context)