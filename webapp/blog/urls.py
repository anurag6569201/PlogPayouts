from django.urls import path
from blog import views
from .views import PostListView, PostCreateView, PostDetailView, PostUpdateView, PostDeleteView, LikePostView, CommentCreateView, CommentUpdateView, CommentDeleteView

app_name="blog"

urlpatterns = [
    path('', PostListView.as_view(), name='blog'),
    path('post/new', PostCreateView.as_view(), name='blog-new'),
    path('post/<int:pk>', PostDetailView.as_view(), name='blog-detail'),
    path('post/<int:pk>/update', PostUpdateView.as_view(), name='blog-update'),
    path('post/<int:pk>/delete', PostDeleteView.as_view(), name='blog-delete'),
    path('post/<int:pk>/like/', LikePostView.as_view(), name='like-post'),
    path('post/<int:pk>/comment/', CommentCreateView.as_view(), name='comment-create'),
    path('post/<int:pk>/comment/<int:comment_pk>/update/', CommentUpdateView.as_view(), name='comment-update'),
    path('post/<int:pk>/comment/<int:comment_pk>/delete/', CommentDeleteView.as_view(), name='comment-delete'),
]