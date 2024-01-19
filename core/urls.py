from django.urls import path
from core import views
from .views import UserProfileUpdateView

app_name="core"

urlpatterns=[
    path('',views.index,name='index'),
    path('verifier-index',views.verifier,name='verifier'),
    path('redeem', views.user_redeem, name='redeem'),
    path('profile/verifier', views.user_profile, name='profile'),
    path('profile/verifier/edit', UserProfileUpdateView.as_view(), name='verifier_edit'),
]
