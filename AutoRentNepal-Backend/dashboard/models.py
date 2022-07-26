
from pyexpat import model
from tkinter import CASCADE

from django.db import models
from django.contrib.auth.models import AbstractUser, User
from accounts.models import CustomUser
# Create your models here.


class Brand(models.Model):

    image = models.ImageField(upload_to='Brands/', blank=True, null=True)
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


class Vehicle(models.Model):
  
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    Brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="vehiclesImages/")
    seater = models.CharField(max_length=100, default='seater')
    car_Type = models.CharField(max_length=100, default='car type')
    engine = models.CharField(max_length=100, default='engine')
    rental_price = models.PositiveIntegerField()
    descrition = models.TextField()

    def __str__(self):
        return self.title


class PopularVehicle(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.vehicle.title


class MostSearcedVehicle(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.vehicle.title


class Favourite(models.Model):
    id = models.AutoField(primary_key=True)
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE,)
    User = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    isFavourite = models.BooleanField(default=False)

    def __str__(self):
        return f"User = {self.User.username} has clicked Favourite = {self.isFavourite} for Vehicle Name = {self.vehicle.title}"


class AddToCart(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isComplete = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User={self.user.username}|isComplete={self.isComplete}"


class CartVehicle(models.Model):
    cart = models.ForeignKey(AddToCart, on_delete=models.CASCADE)
    vehicle = models.ManyToManyField(Vehicle)
    price = models.PositiveIntegerField()
    quntity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField(default=0)

    def __str__(self):
        return f"Cart=={self.cart.id}<==>CartProduct:{self.id}==Qualtity=={self.quntity}"




class Rent(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, default='')
    vehicle = models.OneToOneField(Vehicle, on_delete=models.CASCADE)
    address = models.CharField(max_length=150)
    start_date = models.DateField()
    end_date = models.DateField()
    document_upload = models.ImageField(upload_to="documents/" ,blank=True, null=True)

    def __str__(self):
        return f"User = {self.user.username}"
    


class Advertise(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    image = models.ImageField(upload_to="AdvertiseImages/")
    description = models.TextField()
    price = models.PositiveIntegerField()

    def __str__(self):
        return self.title


class Feedback(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    title = models.TextField()

    def __str__(self):
        return f"user = {self.user.username} has submitted the feedback. Click here to check the feedback"
