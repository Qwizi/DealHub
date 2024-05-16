import random

from allauth.account.signals import user_signed_up
from django.conf import settings
from django.contrib.auth.models import AbstractUser, PermissionsMixin
from django.db import models
from django.dispatch import receiver


class Account(AbstractUser, PermissionsMixin):
    groups = models.ManyToManyField(
        'auth.Group',
        blank=True,
        help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.',
        related_name='account_set',
        related_query_name='account',
        verbose_name='groups'
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        blank=True,
        help_text='Specific permissions for this user.',
        related_name='account_set',
        related_query_name='account',
        verbose_name='user permissions'
    )

    avatar = models.CharField(max_length=255, blank=True, null=True)

    def get_random_avatar(self):
        style = settings.DICE_BEAR_STYLE
        seed = random.choice(settings.DICE_BEAR_SEEDS[style])
        self.avatar = f"https://api.dicebear.com/8.x/{style}/svg?seed={seed}"
        self.save()



@receiver(user_signed_up)
def user_signed_up_(request, user, **kwargs):
    # Your code here. For example:
    print(f"User {user.username} signed up")
    user.get_random_avatar()
