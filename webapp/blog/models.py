from django.db import models
from django.utils import timezone
from userauths.models import User,UserProfile
from django_ckeditor_5.fields import CKEditor5Field
# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=200)
    content = CKEditor5Field('Text', config_name='extends')
    date_posted = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    authorProfile = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    blog_image = models.ImageField(upload_to='blog_images/', null=True, blank=True)

    def __str__(self):
        return self.title
    
    likes = models.ManyToManyField(User, related_name='post_likes', blank=True)

    def like(self, user):
        if user in self.likes.all():
            self.likes.remove(user)
        else:
            self.likes.add(user)
    
    comments = models.ManyToManyField('Comment', related_name='post_comments', blank=True)

class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comment by {self.author.username} on {self.post.title}"