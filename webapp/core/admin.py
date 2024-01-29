from django.contrib import admin
from .models import ScratchCard

class ScratchCardAdmin(admin.ModelAdmin):
    list_display = ('cid','code', 'points', 'is_redeemed', 'expiration_date', 'issued_date', 'last_redeemed_date')
    list_filter = ('is_redeemed', 'expiration_date')
    search_fields = ('code',)

admin.site.register(ScratchCard, ScratchCardAdmin)