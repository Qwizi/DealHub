from django.conf import settings
from django.db import models


class Offer(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="accounts", null=True,
                               blank=True)
    category = models.ForeignKey("categories.Category", on_delete=models.CASCADE, related_name="offers", null=True)
    images = models.TextField()
    description = models.TextField(default="ESZ")
    price = models.FloatField(default=50)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

    def get_images(self):
        return self.images.split('\n')
# Create your models here.
