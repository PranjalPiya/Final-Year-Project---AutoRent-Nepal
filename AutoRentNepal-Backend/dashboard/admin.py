from pyexpat import model
from django.contrib import admin
from .models import Brand, Vehicle, Favourite,Rent, AddToCart, PopularVehicle, MostSearcedVehicle, CartVehicle, Advertise, Feedback

class RentAdmin(admin.ModelAdmin):
    list_display = ('user','address','start_date', 'end_date','vehicle', 'document_upload')

class VehicleAdmin(admin.ModelAdmin):
    list_display = ('Brand',"title", 'seater','car_Type', 'engine', 'rental_price')

# class FavouriteAdmin(admin.ModelAdmin):
#     list_display = ('vehicle', 'User')

class CartVehicleAdmin(admin.ModelAdmin):
    list_display = ('cart','price')



# Register your models here.
admin.site.register([Brand,
                    AddToCart, MostSearcedVehicle, PopularVehicle, Advertise, Feedback])

admin.site.register(Vehicle,VehicleAdmin)

admin.site.register(Rent,RentAdmin)
admin.site.register(CartVehicle,CartVehicleAdmin)
admin.site.register(Favourite)





admin.site.site_header = "AutoRent Nepal Administration"

