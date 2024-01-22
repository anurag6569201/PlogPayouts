from django.forms.models import BaseModelForm
from django.shortcuts import render
from django.http import HttpResponse
from blog.models import Post
from userauths.models import UserProfile
from django.views.generic import ListView,DetailView,CreateView,UpdateView,DeleteView
from django.urls import reverse
from django.contrib.auth.mixins import LoginRequiredMixin,UserPassesTestMixin

class PostListView(LoginRequiredMixin,ListView):
    
    model=Post
    template_name='core/blog.html'
    context_object_name='posts'
    ordering=['date_posted']

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user_profile'] = UserProfile.objects.get(user=self.request.user)
        return context

class PostDetailView(LoginRequiredMixin,DetailView):
    model=Post
    template_name='core/post_detail.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user_profile'] = UserProfile.objects.get(user=self.request.user)
        return context

class PostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    fields = ['title', 'content', 'blog_image']
    template_name = 'core/post_form.html'
    

    def form_valid(self, form):
        form.instance.author = self.request.user
        form.instance.authorProfile = UserProfile.objects.get(user=self.request.user)
        return super().form_valid(form)

    def get_success_url(self):
        return reverse('blog:blog-detail', kwargs={'pk': self.object.pk})

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user_profile = UserProfile.objects.get(user=self.request.user)
        context["user_profile"] = user_profile
        context['userposts'] = Post.objects.filter(author=self.request.user)
        return context

    def test_func(self):
        post=self.get_object()
        if self.request.user==post.author:
            return True
        return False
    
class PostUpdateView(LoginRequiredMixin,UserPassesTestMixin,UpdateView):
    model=Post
    fields = ['title', 'content', 'blog_image']
    template_name = 'core/post_form.html'

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user_profile = UserProfile.objects.get(user=self.request.user)
        context["user_profile"] = user_profile
        context['userposts'] = Post.objects.filter(author=self.request.user)
        return context


    def get_success_url(self):
        return reverse('blog:blog-new')
    
    def test_func(self):
        post=self.get_object()
        if self.request.user==post.author:
            return True
        return False
    
class PostDeleteView(DeleteView):
    model=Post
    template_name = 'core/post_confirm_delete.html'
        
    def get_success_url(self):
        return reverse('blog:blog-new')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        user_profile = UserProfile.objects.get(user=self.request.user)
        context["user_profile"] = user_profile
        context['userposts'] = Post.objects.filter(author=self.request.user)
        return context

    def test_func(self):
        post=self.get_object()
        if self.request.user==post.author:
            return True
        return False