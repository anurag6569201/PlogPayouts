# Generated by Django 5.0 on 2024-02-12 06:27

import ckeditor_uploader.fields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0003_post_authorprofile_post_blog_image_post_likes_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='content',
            field=ckeditor_uploader.fields.RichTextUploadingField(blank=True, default='Write a post...', null=True),
        ),
    ]
