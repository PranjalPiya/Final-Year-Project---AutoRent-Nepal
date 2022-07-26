from tokenize import group
from django.contrib import admin

from .models import CustomUser, UserProfile, Driver



class UserAdmin(admin.ModelAdmin):
    list_display = ('username','full_name', 'email','phone_number')

class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user','profile_image')

class DriverAdmin(admin.ModelAdmin):
    list_display = ('name','age','phone', 'image')

# Register your models here.
admin.site.register(Driver, DriverAdmin)
admin.site.register(UserProfile, UserProfileAdmin)

admin.site.register(CustomUser, UserAdmin)


