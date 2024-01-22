from django.urls import path
from blog import views
from .views import PostListView,PostDetailView,PostCreateView,PostUpdateView,PostDeleteView

app_name="blog"

urlpatterns=[
    path('',PostListView.as_view(),name='blog'),
    path('post/new',PostCreateView.as_view(),name='blog-new'),
    path('post/<int:pk>',PostDetailView.as_view(),name='blog-detail'),
    path('post/<int:pk>/update',PostUpdateView.as_view(),name='blog-update'),
    path('post/<int:pk>/delete',PostDeleteView.as_view(),name='blog-delete'),
]
