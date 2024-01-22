from django.db import models
from django.utils import timezone
from userauths.models import User,UserProfile
# Create your models here.

class Post(models.Model):
    title=models.CharField(max_length=200)
    content=models.TextField()
    date_posted=models.DateTimeField(default=timezone.now)
    author=models.ForeignKey(User,on_delete=models.CASCADE)
    authorProfile=models.ForeignKey(UserProfile,on_delete=models.CASCADE)
    blog_image = models.ImageField(upload_to='blog_images/', null=True, blank=True)

    def __str__(self):
        return self.title