# Generated by Django 5.0.6 on 2024-06-16 19:00

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('offers', '0005_offer_reviews'),
        ('reviews', '0002_alter_review_author'),
    ]

    operations = [
        migrations.AddField(
            model_name='review',
            name='review',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='offers.offer'),
            preserve_default=False,
        ),
    ]
