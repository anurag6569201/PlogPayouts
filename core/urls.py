from django.urls import path
from core import views

app_name="core"

urlpatterns=[
    path('',views.index,name='index'),
    path('verifier',views.verifier,name='verifier'),
    path('verifier/edit/',views.edit_verifier, name='edit_verifier'),
    path('verifier/save/',views.save_verifier, name='save_verifier'),
    path('redeem', views.user_redeem, name='redeem'),
]