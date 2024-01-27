from django.urls import path
from .views import home, show_path

urlpatterns = [
    path('', home, name='home'),
    path('show_path/', show_path, name='show_path'),  # Add this line
]