from django.shortcuts import render,HttpResponse,redirect
from core.models import ScratchCard
from django.db.models import Sum

# Create your views here.
from userauths.models import UserProfile
from userauths.forms import UserProfileForm

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
    return render(request, 'core/verifier.html', context)

def edit_verifier(request):
    user_profile = UserProfile.objects.first()
    context = {
        "user_profile": user_profile,
        "edit_mode": True,
    }
    return render(request, 'core/edit_verifier.html', context)

def save_verifier(request):
    if request.method == 'POST':
        user_profile = UserProfile.objects.first()
        form = UserProfileForm(request.POST, instance=user_profile)
        if form.is_valid():
            form.save()
            return redirect('verifier')
    return redirect('core:verifier')

@login_required(login_url='userauths:sign-in') 

def user_redeem(request):
    vouchers=ScratchCard.objects.filter(user=request.user)
    totalpoints = ScratchCard.objects.filter(user=request.user).aggregate(Sum('points'))['points__sum'] or 0

    context={
        "vouchers":vouchers,
        "totalpoints":totalpoints
    }
    return render(request,'core/redeem.html',context)
