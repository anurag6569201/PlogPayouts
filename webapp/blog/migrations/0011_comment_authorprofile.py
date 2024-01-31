# Generated by Django 5.0 on 2024-01-23 20:37

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0010_remove_comment_authorprofile'),
        ('userauths', '0011_alter_userprofile_name_alter_userprofile_surname'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='authorProfile',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='userauths.userprofile'),
            preserve_default=False,
        ),
    ]