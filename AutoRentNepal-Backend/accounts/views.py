#import imp
#from django.shortcuts import render
#from urllib import response


from cProfile import Profile
from lib2to3.pgen2.parse import ParseError
from .serializers import *
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework.parsers import JSONParser, MultiPartParser, FormParser
from rest_framework import status
from rest_framework.decorators import action
# Create your views here.


class UserProfileView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        customer_obj = UserProfile.objects.get(user=request.user)
        customer_ser = UserProfileSerializer(customer_obj).data
        return Response(customer_ser)

# Update CustomeUser


class UserUpdateView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            user = request.user
            data = request.data
            user_obj = CustomUser.objects.get(username=user)
            user_obj.full_name = data["full_name"]
            user_obj.phone_number = data["phone_number"]
            user_obj.email = data["email"]
            user_obj.save()
            response_data = {"error": True, "message": "User Data is Updated"}
        except:
            response_data = {"error": False,
                             "message": "Error while updating user details"}
        return Response(response_data)

# Update CustomeUserProfile


class UserProfileUpdateView(APIView):


    parser_classes = [MultiPartParser, FormParser, ]

    def post(self, request):
        try:
            user = request.user
            query = UserProfile.objects.get(user=user)
            data = request.data
            serializers = UserProfileSerializer(
                query, data=data, context={"request": request})
            serializers.is_valid(raise_exception=True)
            serializers.save()
            return_res = {"message": "Profile is updated"}
        except:
            return_res = {"message": "Profile is not updated"}
        return Response(return_res)


# Driver Views
class DriverView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Driver.objects.all()
        serializer = DriverSerializer(query, many=True)
        return Response(serializer.data)


class resetpassword(APIView):
    def post(self, request):
        serializer = resetpasswordSerializer(data=request.data)
        alldatas = {}
        if serializer.is_valid(raise_exception=True):
            mname = serializer.save()
            alldatas['data'] = 'password successfully changed'
            print(alldatas)
            return Response(alldatas)
        return Response('failed retry after some time')



