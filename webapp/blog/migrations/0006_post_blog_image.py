# Generated by Django 5.0 on 2024-02-12 07:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0005_remove_post_blog_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='blog_image',
            field=models.ImageField(blank=True, null=True, upload_to='blog_images/'),
        ),
    ]
