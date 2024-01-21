from enum import unique
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=100)
    verified =  models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    groups = models.ManyToManyField(
        "auth.Group",
        related_name="userauths_user_set",
        blank=True,
        help_text="The groups this user belongs to. A user will get all permissions granted to each of their groups.",
        verbose_name="groups",
    )
    
    user_permissions = models.ManyToManyField(
        "auth.Permission",
        related_name="userauths_user_set",
        blank=True,
        help_text="Specific permissions for this user.",
        verbose_name="user permissions",
    )

    def __str__(self):
        return self.username
    
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, default="user")
    surname = models.CharField(max_length=100, default="1234")
    mobile_number = models.CharField(max_length=15, default="XXXXXXXXXX")
    address = models.CharField(max_length=255, default="No Address Provided")
    postcode = models.CharField(max_length=20, default="XXXXXX")
    area = models.CharField(max_length=100, default="Unknown Area")
    email = models.EmailField(default="example@example.com")
    education = models.CharField(max_length=255, default="No Education Information")
    country = models.CharField(max_length=100, default="Unknown Country")
    state_region = models.CharField(max_length=100, default="Unknown Region")
    profile_image = models.ImageField(upload_to='profile_images/', null=True, blank=True)

    def __str__(self):
        return self.user.username