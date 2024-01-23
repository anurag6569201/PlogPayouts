from django.forms.models import BaseModelForm
from django.shortcuts import render,redirect
from django.http import HttpResponse
from blog.models import Post
from userauths.models import UserProfile
from django.views.generic import ListView,DetailView,CreateView,UpdateView,DeleteView
from django.urls import reverse
from django.contrib.auth.mixins import LoginRequiredMixin,UserPassesTestMixin
from django.shortcuts import get_object_or_404
from django.http import HttpResponseRedirect
from .models import Post, Comment
from .forms import CommentForm


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

    def get(self, request, *args, **kwargs):
        post = get_object_or_404(Post, pk=self.kwargs['pk'])
        comments = Comment.objects.filter(post=post)
        comment_form = CommentForm()
        user_profile = UserProfile.objects.get(user=self.request.user)
        userposts= Post.objects.filter(author=self.request.user)
        context = {'post': post, 'comments': comments, 'comment_form': comment_form,'userposts':userposts,'user_profile':user_profile}
        return render(request, self.template_name, context)

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
    

from django.shortcuts import get_object_or_404
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.views import View
from .models import Post

class LikePostView(View):
    def get(self, request, *args, **kwargs):
        post = get_object_or_404(Post, pk=self.kwargs['pk'])
        post.like(request.user)
        return HttpResponseRedirect(reverse('blog:blog-detail', args=[str(post.id)]))


class CommentCreateView(View):
    def post(self, request, *args, **kwargs):
        post = get_object_or_404(Post, pk=self.kwargs['pk'])
        form = CommentForm(request.POST)

        if form.is_valid(): 
            comment = form.save(commit=False)
            comment.post = post
            comment.author = request.user
            comment.save()
        return redirect('blog:blog-detail', pk=post.id)

class CommentUpdateView(View):
    template_name = 'core/comment_edit.html'

    def get(self, request, *args, **kwargs):
        comment = get_object_or_404(Comment, pk=self.kwargs['comment_pk'])
        form = CommentForm(instance=comment)
        post = get_object_or_404(Post, pk=self.kwargs['pk'])
        comments = Comment.objects.filter(post=post)
        comment_form = CommentForm()
        return render(request, self.template_name, {'form': form, 'comment': comment,'post': post, 'comments': comments, 'comment_form': comment_form})

    def post(self, request, *args, **kwargs):
        comment = get_object_or_404(Comment, pk=self.kwargs['comment_pk'])
        form = CommentForm(request.POST, instance=comment)

        if form.is_valid():
            form.save()
            return redirect('blog:blog-detail', pk=comment.post.id)
        else:
            print(form.errors)
            return render(request, self.template_name, {'form': form, 'comment': comment})
        

class CommentDeleteView(View):
    def get(self, request, *args, **kwargs):
        comment = get_object_or_404(Comment, pk=self.kwargs['comment_pk'])
        post_id = comment.post.id
        comment.delete()
        return redirect('blog:blog-detail', pk=post_id)