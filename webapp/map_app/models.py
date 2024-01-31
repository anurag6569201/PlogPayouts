from django.db import models
from userauths.models import User
from userauths.models import User
import uuid

class Location(models.Model):
    name = models.CharField(max_length=255)
    latitude = models.FloatField()
    longitude = models.FloatField()

    def __str__(self):
        return self.name
    
class PredictionModel(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    count = models.IntegerField()
    prediction = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    score_of_image= models.IntegerField(default="0")
    is_redeemed = models.BooleanField(default=False)