#import os
from email.policy import default
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.dispatch import receiver
from django.db.models.signals import post_save
from rest_framework.authtoken.models import Token


class CustomUser(AbstractUser):

    full_name = models.CharField(max_length=30)
    phone_number = models.CharField(max_length=30)

    # def __str__(self):
    # return self.full_name


class UserProfile(models.Model):
    user = models.OneToOneField(
        CustomUser, on_delete=models.CASCADE)
    profile_image = models.ImageField(
        upload_to="ProfileImages/", default="no_profile.jpg")

    def __str__(self):
        return f"{self.user.username} profile picture"


@receiver(post_save, sender=CustomUser)
def createUserProfile(sender, instance, created, *args, **kwargs):
    if created:
        UserProfile.objects.create(user=instance)
        Token.objects.create(user=instance)


class Driver(models.Model):
    name = models.CharField(max_length=150)
    age = models.CharField(max_length=100)
    image = models.ImageField(upload_to="DriverImages/")
    phone = models.CharField(max_length=100)
    about = models.TextField()

    def __str__(self):
        return self.name
