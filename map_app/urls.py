from django.urls import path
from .views import home, show_path,show_contributions

urlpatterns = [
    path('', home, name='home'),
    path('show_path/', show_path, name='show_path'),  # Add this line
    path('show_contributions/', show_contributions, name='show_contributions'),  # Add this line
]