from dataclasses import field
from itertools import product
from rest_framework import serializers, fields
from .models import *


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = "__all__"
        depth = 1


class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = '__all__'
        depth = 1


class PopularVehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = PopularVehicle
        fields = "__all__"

    def to_representation(self, instance):
        response = super().to_representation(instance)
        request = self.context.get('request')
        response['vehicles'] = VehicleSerializer(
            instance.vehicle, context={'request': request}).data
        return response


class MostSearchedVehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = MostSearcedVehicle
        fields = "__all__"

    def to_representation(self, instance):
        response = super().to_representation(instance)
        request = self.context.get('request')
        response['vehicles'] = VehicleSerializer(
            instance.vehicle, context={'request': request}).data
        return response


class AdvertiseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Advertise
        fields = "__all__"
        depth = 1

   


class RentSerializers(serializers.ModelSerializer):

   

    class Meta:
        model = Rent
        fields="__all__"
      
        depth=1



class AddToCartSerializers(serializers.ModelSerializer):
    class Meta:
        model = AddToCart
        fields = "__all__"
       # depth = 1


class CartVehicleSerializers(serializers.ModelSerializer):
    class Meta:
        model = CartVehicle
        fields = "__all__"
        depth = 1


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = ['user', 'title']
        depth = 1
