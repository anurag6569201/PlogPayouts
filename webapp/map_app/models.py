from django.db import models
from userauths.models import User

class Location(models.Model):
    name = models.CharField(max_length=255)
    latitude = models.FloatField()
    longitude = models.FloatField()

    def __str__(self):
        return self.name
    
class PredictionModel(models.Model):
    count = models.IntegerField()
    prediction = models.CharField(max_length=255)
    status = models.CharField(max_length=255)