# Generated by Django 5.0.6 on 2024-06-10 17:05

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('offers', '0003_offer_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='offer',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]
