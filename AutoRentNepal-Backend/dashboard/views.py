
#from turtle import title
from audioop import add
import re
from turtle import title
from urllib import response
from django.utils import timezone
from .serializers import *
from .models import *
from django.db.models import Q
from rest_framework.views import APIView
from rest_framework.generics import ListAPIView
from rest_framework import generics, filters
from rest_framework.response import Response
from rest_framework.parsers import JSONParser, MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework import status



# Create your views here.

# view for Vehicles Brands
class BrandView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Brand.objects.all()
        serializer = BrandSerializer(query, many=True)
        return Response(serializer.data)

# View for displaying vheicles based on brand clicked.


class SingleBrandVehiclesView(APIView):
    def get(self, request, pk):
        brand_obj = Brand.objects.filter(id=pk)
        brand_serializer = BrandSerializer(
            brand_obj, many=True, context={'request': request})
        data = []
        for brand in brand_serializer.data:
            brandVehicles = Vehicle.objects.filter(Brand=brand['id'])
            brandVehicles_serializer = VehicleSerializer(
                brandVehicles, many=True, context={'request': request})
            brand['vehicles'] = brandVehicles_serializer.data
            data.append(brand)
        return Response(data)

# View for Vehicles


class VehicleView(ListAPIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Vehicle.objects.all()
        data = []
        serializers = VehicleSerializer(
            query, many=True,  context={'request': request})

        for vehicle in serializers.data:
            fav_query = Favourite.objects.filter(User=request.user).filter(
                vehicle_id=vehicle['id']
            )
            if fav_query:
                vehicle['favourite'] = fav_query[0].isFavourite
            else:
                vehicle['favourite'] = False
            data.append(vehicle)

        return Response(data)


class favouriteView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        data = request.data["id"]
        try:
            vehicle_obj = Vehicle.objects.get(
                id=data)
            print(data)
            user = request.user
            single_favourite_vehicle = Favourite.objects.filter(
                User=user
            ).filter(vehicle=vehicle_obj).first()
            if single_favourite_vehicle:
                print('single_favourite_vehicle')
                a = single_favourite_vehicle.isFavourite
                single_favourite_vehicle.isFavourite = not a
                single_favourite_vehicle.save()

            else:
                Favourite.objects.create(
                    vehicle=vehicle_obj, User=user, isFavourite=True
                )

            response_msg = {'message': False}
        except:
            response_msg = {'message': True}
        return Response(response_msg)


class AdvertiseView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

   

    def get(self, request):
        advertise_obj = Advertise.objects.all()
        advertise_serializer = AdvertiseSerializer(
            advertise_obj, many=True, context={'request': request})
        return Response(advertise_serializer.data)


class PopularVehicleView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        data = []
        vehicles_obj = PopularVehicle.objects.all()
        vehicle_serializer = PopularVehicleSerializer(
            vehicles_obj, many=True, context={'request': request}).data
        for vehicle in vehicle_serializer:
            fav_query = Favourite.objects.filter(User=request.user).filter(
                vehicle_id=vehicle['id']
            )
            if fav_query:
                vehicle['favourite'] = fav_query[0].isFavourite
            else:
                vehicle['favourite'] = False
            data.append(vehicle)
        return Response(data)
        # return Response(vehicle_serializer)


class MostSearchedVehicleView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        data = []
        vehicles_obj = MostSearcedVehicle.objects.all()
        vehicle_serializer = MostSearchedVehicleSerializer(
            vehicles_obj, many=True, context={'request': request}).data
        for vehicle in vehicle_serializer:
            fav_query = Favourite.objects.filter(User=request.user).filter(
                vehicle_id=vehicle['id']
            )
            if fav_query:
                vehicle['favourite'] = fav_query[0].isFavourite
            else:
                vehicle['favourite'] = False
            data.append(vehicle)
        return Response(data)





class SearchView(APIView):
    def get(self, request, q):

        data = {}
        vehicle_searchup = (Q(title__icontains=q) |
                            Q(descrition__icontains=q) |
                            Q(rental_price__icontains=q))
        vehicle_obj = Vehicle.objects.filter(
            # titleID=Vehicle["title"],
            date__lte=timezone.now(),
            # time__lte=timezone.now()
        ).filter(vehicle_searchup)

        data['vehicles'] = VehicleSerializer(
            vehicle_obj, many=True, context={'request': request}).data
        print(vehicle_obj)
        return Response(data)




class RentView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        try:
            query = Rent.objects.filter(user=request.user)
            serializers = RentSerializers(query, many=True,context={'request': request} )
            response_msg = {"error": False, "data": serializers.data}
        except:
            response_msg = {"error": True, "data": "no data"}
        return Response(response_msg)


class RentCreate(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    parser_classes = [MultiPartParser, FormParser, ] 
    
    def post(self, request):
        try:
            # r_user = request.user
            r_user = request.user
            data = request.data
            
            vehicle_id = data['vehicleid']
            r_address = data['address']
            r_start_date = data['start_date']
            r_end_date = data['end_date']
            r_document_upload = data['document_upload']
            vehicle_obj = Vehicle.objects.get(id=vehicle_id)
            vehicle_obj.save()
            Rent.objects.create(
                user=r_user,
                vehicle=vehicle_obj,
                start_date=r_start_date,
                address=r_address,
                end_date=r_end_date,
                document_upload = r_document_upload,
            )
            response_msg = {"error": False, "message": "Vehicle Rented Successfully"}
        except:
            response_msg = {"error": True, "message": "Error while renting vehicle"}
        return Response(response_msg)





class CartView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        try:
            cart_obj = AddToCart.objects.filter(
                user=user).filter(isComplete=False)
            data = []
            addToCart_serializer = AddToCartSerializers(cart_obj, many=True)

            for cart in addToCart_serializer.data:
                cart_vehicle_obj = CartVehicle.objects.filter(cart=cart["id"])
                cart_vehicle_obj_serializer = CartVehicleSerializers(
                    cart_vehicle_obj, many=True)
                cart['cartvehicles'] = cart_vehicle_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg)
       # return Response(addToCart_serializer.data)

# Adding vehicles to cart


class AddVehicleToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        vehicle_id = request.data['id']
        vehicle_obj = Vehicle.objects.get(id=vehicle_id)
        # print(product_obj, "product_obj")
        cart_cart = AddToCart.objects.filter(
            user=request.user).filter(isComplete=False).first()
        cart_vehicle_obj = CartVehicle.objects.filter(
            vehicle__id=vehicle_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_vehicle_in_cart = cart_cart.cartvehicle_set.filter(
                    vehicle=vehicle_obj)
                if this_vehicle_in_cart.exists():
                    cartprod_uct = CartVehicle.objects.filter(
                        vehicle=vehicle_obj).filter(cart__isComplete=False).first()
                    cartprod_uct.quntity += 1
                    cartprod_uct.subtotal += vehicle_obj.rental_price
                    cartprod_uct.save()
                    cart_cart.total += vehicle_obj.rental_price
                    cart_cart.save()
                else:
                    print("NEW CART VEHICLE CREATED--OLD CART")
                    cart_vehicle_new = CartVehicle.objects.create(
                        cart=cart_cart,
                        price=vehicle_obj.rental_price,
                        quntity=1,
                        subtotal=vehicle_obj.rental_price
                    )
                    cart_vehicle_new.vehicle.add(vehicle_obj)
                    cart_cart.total += vehicle_obj.rental_price
                    cart_cart.save()
            else:
                AddToCart.objects.create(user=request.user,
                                         total=0, isComplete=False)
                new_cart = AddToCart.objects.filter(
                    user=request.user).filter(isComplete=False).first()
                cart_vehicle_new = CartVehicle.objects.create(
                    cart=new_cart,
                    price=vehicle_obj.rental_price,
                    quntity=1,
                    subtotal=vehicle_obj.rental_price
                )
                cart_vehicle_new.vehicle.add(vehicle_obj)
                new_cart.total += vehicle_obj.rental_price
                new_cart.save()
            response_mesage = {
                'error': False, 'message': "Vehicle add to card successfully", "vehicleid": vehicle_id}
        except:
            response_mesage = {'error': True,
                               'message': "Vehicle is Not added! Somthing is Wromg"}
        return Response(response_mesage)

# This view is for deleting a single vehicle from the cart


class DelateVehicleCart(APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        cart_vehicle_id = request.data['id']
        try:
            cart_vehicle_obj = CartVehicle.objects.get(id=cart_vehicle_id)
            cart_cart = AddToCart.objects.filter(
                user=request.user).filter(isComplete=False).first()
            cart_cart.total -= cart_vehicle_obj.subtotal
            cart_vehicle_obj.delete()
            cart_cart.save()
            response_msg = {'error': False,
                            'message': 'The vehicle is deleted from the cart'}
        except:
            response_msg = {
                'error': True, 'message': 'The vehicle is not deleted from the cart'}
        return Response(response_msg)

# for deleting all the items in the cart
class DeleteRentHistoryVehicle(APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        vehicle_id = request.data['id']
        try:
            vehicle_obj = Rent.objects.get(id=vehicle_id)
            # rent_vehicle = Rent.objects.filter(user=request.user).first()
            vehicle_obj.delete()
         

            response_msg = {'error': False,
                            'message': 'The rented vehicle is deleted from the history'}
        except:
            response_msg = {'error': True,
                            'message': 'Error while deleting rental vehicle'}
        return Response(response_msg)





class DeleteAllCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = AddToCart.objects.get(id=cart_id)
            cart_obj.delete()
            response_msg = {'error': False,
                            'message': 'Cart deleted successfully'}
        except:
            response_msg = {'error': True, 'message': 'Cart was not deleted '}
        return Response(response_msg)


class FeebackView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            f_user = request.user
            data = request.data
            feedback_text = data["title"]
            Feedback.objects.create(
                user=f_user,
                title=feedback_text,

            )
            return Response({"error": False, "message": "Feedback was submitted"})
        except:
            return Response({"error": True, "message": "Feedback was not submitted"})
