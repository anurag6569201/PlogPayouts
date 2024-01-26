from django import forms
from django.contrib.auth.forms import UserCreationForm
from userauths.models import User
from .models import UserProfile
from django.forms.widgets import ClearableFileInput
from .models import Contribution

class UserRegisterForm(UserCreationForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']

class UserProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = 'name','surname','mobile_number','address','postcode','area','email','education','country','state_region','profile_image'

        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'surname': forms.TextInput(attrs={'class': 'form-control'}),
            'mobile_number': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'postcode': forms.TextInput(attrs={'class': 'form-control'}),
            'area': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'education': forms.TextInput(attrs={'class': 'form-control'}),
            'country': forms.TextInput(attrs={'class': 'form-control'}),
            'state_region': forms.TextInput(attrs={'class': 'form-control'}),
            'profile_image': ClearableFileInput(attrs={'class': 'form-control', 'type': 'file'}),
        }

class ContactForm(forms.Form):
    name=forms.CharField(max_length=255)
    email=forms.EmailField()
    content=forms.CharField(widget=forms.Textarea)

class ContributionForm(forms.ModelForm):
    class Meta:
        model = Contribution
        fields = ['latitude', 'longitude', 'image']