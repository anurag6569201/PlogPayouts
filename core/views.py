from django.shortcuts import render,HttpResponse,redirect
from core.models import ScratchCard
from django.db.models import Sum

# Create your views here.
from userauths.models import UserProfile
from userauths.forms import UserProfileForm
from django.views.generic.edit import FormView
from django.urls import reverse_lazy

from django.contrib.auth.decorators import login_required



@login_required(login_url='userauths:sign-in') 
def index(request):
    return render(request,'core/index.html')



@login_required(login_url='userauths:sign-in') 
def verifier(request):
    user_profile = UserProfile.objects.first()
    context = {
        "user_profile": user_profile,
        "edit_mode": False,
    }
    return render(request, 'core/index_verifier.html', context)



def user_profile(request):
    user_profile = UserProfile.objects.first()
    context = {
        "user_profile": user_profile,
        "edit_mode": False,
    }
    return render(request, 'core/verifier.html',context)





@login_required(login_url='userauths:sign-in') 
def user_redeem(request):
    vouchers=ScratchCard.objects.filter(user=request.user)
    totalpoints = ScratchCard.objects.filter(user=request.user).aggregate(Sum('points'))['points__sum'] or 0

    context={
        "vouchers":vouchers,
        "totalpoints":totalpoints
    }
    return render(request,'core/redeem.html',context)



class UserProfileUpdateView(FormView):
    template_name = 'core/edit_verifier.html'
    form_class = UserProfileForm
    success_url = reverse_lazy('core:profile')

    def get_form_kwargs(self):
        kwargs = super(UserProfileUpdateView, self).get_form_kwargs()
        kwargs['instance'] = UserProfile.objects.first()
        return kwargs

    def form_valid(self, form):
        form.save()
        return super(UserProfileUpdateView, self).form_valid(form)

    def get_context_data(self, **kwargs):
        context = super(UserProfileUpdateView, self).get_context_data(**kwargs)
        context['user_profile'] = UserProfile.objects.first()
        return context

    def get(self, request, *args, **kwargs):
        return self.render_to_response(self.get_context_data())

    def post(self, request, *args, **kwargs):
        form = self.get_form()
        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)
