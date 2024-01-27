
from django.shortcuts import render
import folium

def home(request):
    return render(request, 'map_app/home.html')

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