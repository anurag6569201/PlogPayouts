from django.contrib import admin
from userauths.models import User
from userauths.models import UserProfile
from userauths.models import Contribution
# Register your models here.

class UserAdmin(admin.ModelAdmin):
    list_display=['username','email','verified']

admin.site.register(User,UserAdmin)

class UserProfileAdmin(admin.ModelAdmin):
    list_display=['name','email','mobile_number']

admin.site.register(UserProfile,UserProfileAdmin)
admin.site.register(Contribution)