from django.shortcuts import render, HttpResponse, redirect
from core.models import ScratchCard
from django.db.models import Sum

from userauths.models import UserProfile
from userauths.forms import UserProfileForm
from django.views.generic.edit import FormView
from django.urls import reverse_lazy

from django.contrib.auth.decorators import login_required
from django.http import Http404

from userauths.views import ContactForm
from django.core.mail import send_mail
from django.template.loader import render_to_string

@login_required(login_url='userauths:sign-in')
def index(request):
    if request.method == "POST":
        form = ContactForm(request.POST)
        
        if form.is_valid():
            name = form.cleaned_data['name']
            email = form.cleaned_data['email']
            content = form.cleaned_data['content']

            html = render_to_string('core/email.html', {
                'name': name,
                'email': email,
                'content': content,
            })

            send_mail("The contact form subject", 'this is the message', email, ['anurag6569201@gmail.com'], html_message=html)
            return redirect("core:index")
    else:
        form = ContactForm()

    try:
        user_profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        raise Http404("User profile not found")

    context = {
        'form': form,
        "user_profile": user_profile,
        "edit_mode": False,
    }

    if not request.user.verified:
        return render(request, 'core/index.html', context)
    else:
        raise Http404("Page not found")

@login_required
def user_redeem(request):
    user_profile = UserProfile.objects.get(user=request.user)
    vouchers = ScratchCard.objects.filter(user=request.user)
    totalpoints = ScratchCard.objects.filter(user=request.user).aggregate(Sum('points'))['points__sum'] or 0

    context = {
        "user_profile": user_profile,
        "vouchers": vouchers,
        "totalpoints": totalpoints
    }
    if not request.user.verified:
        return render(request, 'core/redeem.html', context)
    else:
        raise Http404("Page not found")

@login_required
def mainuser_profile(request):
    user_profile = UserProfile.objects.get(user=request.user)
    context = {
        "user_profile": user_profile,
        "edit_mode": False,
    }
    if not request.user.verified:
        return render(request, 'core/user.html', context)
    else:
        raise Http404("Page not found")

@login_required
def verifier(request):
    user_profile = UserProfile.objects.get(user=request.user)
    context = {
        "user_profile": user_profile,
        "edit_mode": False,
    }
    if request.user.verified:
        return render(request, 'core/index_verifier.html', context)
    else:
        raise Http404("Page not found")

@login_required
def user_profile(request):
    user_profile = UserProfile.objects.get(user=request.user)
    context = {
        "user_profile": user_profile,
        "edit_mode": False,
    }
    if request.user.verified:
        return render(request, 'core/verifier.html', context)
    else:
        raise Http404("Page not found")
    
class UserProfileUpdateView(FormView):
    template_name = 'core/edit_user.html'

    form_class = UserProfileForm
    success_url = reverse_lazy('core:mainuser_profile')

    def get_form_kwargs(self):
        kwargs = super(UserProfileUpdateView, self).get_form_kwargs()
        kwargs['instance'] = UserProfile.objects.get(user=self.request.user)
        return kwargs

    def form_valid(self, form):
        form.save()
        return super(UserProfileUpdateView, self).form_valid(form)

    def get_context_data(self, **kwargs):
        context = super(UserProfileUpdateView, self).get_context_data(**kwargs)
        context['user_profile'] = UserProfile.objects.get(user=self.request.user)
        return context

    def dispatch(self, request, *args, **kwargs):
        if not self.request.user.verified:
            self.template_name = 'core/edit_user.html'
            self.success_url = reverse_lazy('core:mainuser_profile')
        else:
            self.template_name = 'core/edit_verifier.html'
            self.success_url = reverse_lazy('core:profile')

        return super(UserProfileUpdateView, self).dispatch(request, *args, **kwargs)



