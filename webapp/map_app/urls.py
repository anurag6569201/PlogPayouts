from django.urls import path
from .views import show_contributions,show_full,verify_contributions,verifiying

urlpatterns = [
    path('show_contributions/', show_contributions, name='show_contributions'),
    path('show_full/', show_full, name='show_full'),
    path('verify_contributions/', verify_contributions, name='verify_contributions'),
    path('verifiying/', verifiying, name='verifiying'),
    
]