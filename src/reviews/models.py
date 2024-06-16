from django.conf import settings
from django.db import models

# Create your models here.


class Review(models.Model):
    content = models.TextField()
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    review = models.ForeignKey("offers.Offer", on_delete=models.CASCADE)
    stars = models.PositiveIntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.content
