from django.shortcuts import render
from django.http import HttpResponse
from blog.models import Post

def blog(request):
    context = {
        "post": Post.objects.all(),
        "read":Post.objects.all(),
    }
    return render(request, 'core/blog.html',context)

def blogwrite(request):
    context = {
        "post": Post.objects.all(),
        "read":Post.objects.all(),
    }
    return render(request, 'core/blogwrite.html',context)