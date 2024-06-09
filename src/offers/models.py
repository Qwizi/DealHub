from django.conf import settings
from django.db import models

class Offer(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="accounts", null=True, blank=True)
    images = models.TextField()
    price = models.FloatField(default=50)
    is_active = models.BooleanField(default=True)
    
    
# Create your models here.
