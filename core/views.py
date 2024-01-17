from django.shortcuts import render,HttpResponse
from core.models import ScratchCard
from django.db.models import Sum

# Create your views here.
from django.contrib.auth.decorators import login_required

@login_required(login_url='userauths:sign-in') 
def index(request):
    return render(request,'core/index.html')

def verifier(request):
    return render(request,'core/verifier-index.html')


def user_redeem(request):
    vouchers=ScratchCard.objects.filter(user=request.user)
    totalpoints = ScratchCard.objects.filter(user=request.user).aggregate(Sum('points'))['points__sum'] or 0

    context={
        "vouchers":vouchers,
        "totalpoints":totalpoints
    }
    return render(request,'core/redeem.html',context)
