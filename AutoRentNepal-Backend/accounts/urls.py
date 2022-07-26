
from django.urls import path

from .views import *
urlpatterns = [
    path('profile/', UserProfileView.as_view()),
    path('updateuser/', UserUpdateView.as_view(), name="updateuser"),
    path('updateprofile/', UserProfileUpdateView.as_view(),
         name="updateuserprofile"),
    path('driver/', DriverView.as_view()),
    path('resetpassword/', resetpassword.as_view(), name='resetpassword'),
  
]
