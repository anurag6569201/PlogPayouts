# Generated by Django 5.0 on 2024-02-10 13:22

import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='redeemcards',
            name='rcid',
            field=models.UUIDField(default=uuid.uuid4, editable=False, unique=True),
        ),
    ]
