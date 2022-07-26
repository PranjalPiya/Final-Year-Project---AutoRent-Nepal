from django.urls import path


from .views import *
urlpatterns = [
    path('brand/', BrandView.as_view()),
    path('vehicle/', VehicleView.as_view()),
    path('favourite/', favouriteView.as_view()),
    path('advertise/', AdvertiseView.as_view()),
    path('popularvehicles/', PopularVehicleView.as_view()),
    path('rent/', RentView.as_view()),
    path('deleterent/', DeleteRentHistoryVehicle.as_view()),
    path('rentnow/', RentCreate.as_view(), name="rent now"),
    path('cart/', CartView.as_view()),
    path('addtocart/', AddVehicleToCart.as_view()),
    path('deleteSingleCart/', DelateVehicleCart.as_view()),
    path('deleteAllCart/', DeleteAllCart.as_view()),
    path('feedback/', FeebackView.as_view()),
    path('mostsearchedvehicles/', MostSearchedVehicleView.as_view()),
    path('search/<str:q>/', SearchView.as_view()),
    path('singlebrands/<int:pk>/', SingleBrandVehiclesView.as_view()),

]
