from django.urls import path
from .views import show_path,show_contributions,show_full

urlpatterns = [
    path('show_path/', show_path, name='show_path'),  # Add this line
    path('show_contributions/', show_contributions, name='show_contributions'),  # Add this line
    path('show_full/', show_full, name='show_full'),  # Add this line
]