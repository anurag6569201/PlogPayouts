from django.db import models
from django.utils import timezone
from userauths.models import User
import uuid

class ScratchCard(models.Model):
    cid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)   
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    code = models.CharField(max_length=12, unique=True)
    points = models.IntegerField()
    is_redeemed = models.BooleanField(default=False)
    expiration_date = models.DateField(null=True, blank=True)
    issued_date = models.DateTimeField(auto_now_add=True)
    last_redeemed_date = models.DateTimeField(null=True, blank=True)

    def is_expired(self):
        if self.expiration_date and self.expiration_date < timezone.now().date():
            return True
        return False

    def redeem(self):
        if not self.is_redeemed and not self.is_expired():
            self.is_redeemed = True
            self.last_redeemed_date = timezone.now()
            self.save()
            return True
        return False
