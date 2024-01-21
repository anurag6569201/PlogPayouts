from django.urls import path
from blog import views

app_name="blog"

urlpatterns=[
    path('read/',views.blog,name='blog'),
    path('write/',views.blogwrite,name='blogwrite'),
]
