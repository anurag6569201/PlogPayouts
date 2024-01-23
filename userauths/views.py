from django.shortcuts import render, redirect
from userauths.forms import UserRegisterForm
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.conf import settings
from django.contrib.auth import logout
# from userauths.models import User

User=settings.AUTH_USER_MODEL

def register_view(request):
    if request.method == "POST":
        form = UserRegisterForm(request.POST or None)
        if form.is_valid():
            new_user = form.save()
            username = form.cleaned_data.get("username")
            messages.success(request, f"Hey {username}, your account was created successfully")
            
            new_user = authenticate(username=form.cleaned_data['email'], 
                                    password=form.cleaned_data['password1'])
            
            login(request, new_user)
            return redirect("core:index")
    else:
        form=UserRegisterForm()

    context = {
        'form': form,
    }
    return render(request, 'userauths/sign-up.html', context)

def login_view(request):
    if request.user.is_authenticated:
        messages.warning(request, "Hey, You are already logged in.")
        if not request.user.verified:
            return redirect('core:index')
        if request.user.verified:
            return redirect("core:verifier")

    if request.method == "POST":
        email = request.POST.get("email")
        password = request.POST.get("password")
        optradio = request.POST.get("radio-selection")

        user = authenticate(request, email=email, password=password)

        if user is not None:
            if optradio == "verifier-checked":
                if user.verified:
                    login(request, user)
                    messages.success(request, "You are logged in.")
                    return redirect("core:verifier")
                else:
                    messages.warning(request, "Your account is not verified.")

            elif optradio == "user-checked":
                if not user.verified:
                    login(request, user)
                    messages.success(request, "You are logged in.")
                    return redirect("core:index")
                else:
                    messages.warning(request, "You are Not registered as User.")
                    
        else:
            messages.warning(request, "Invalid credentials. Please try again.")

    return render(request, "userauths/sign-in.html")

def logout_view(request):
    logout(request)
    messages.success(request,"You Logged-Out ,successfully")
    return redirect("userauths:sign-in")