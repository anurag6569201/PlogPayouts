# Generated by Django 5.0 on 2024-02-10 13:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_redeemcards_rcid'),
    ]

    operations = [
        migrations.AddField(
            model_name='redeemcards',
            name='score',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
    ]