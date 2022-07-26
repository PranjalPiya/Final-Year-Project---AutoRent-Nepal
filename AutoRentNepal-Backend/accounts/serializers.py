
from dataclasses import fields
from unittest.util import _MAX_LENGTH
from django.db import transaction
from .models import *

from rest_framework import serializers
from dj_rest_auth.registration.serializers import RegisterSerializer
from dj_rest_auth.serializers import UserDetailsSerializer


class CustomRegisterSerializer(RegisterSerializer):
    full_name = serializers.CharField(max_length=30)
    phone_number = serializers.CharField(max_length=30)

    # Define transaction.atomic to rollback the save operation in case of error
    @transaction.atomic
    def save(self, request):
        user = super().save(request)
        user.full_name = self.data.get('full_name')
        user.phone_number = self.data.get('phone_number')
        user.save()
        return user


class CustomUserDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = (
            'pk',
            'email',
            'phone_number',
            'username',
            'full_name',
        )
        read_only_fields = ('pk', 'email', 'phone_number',
                            )


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = "__all__"
        read_only_fields = ['user']
        #depth = 1

    def validate(self, attrs):
        attrs['user'] = self.context['request'].user
        return attrs

    def to_representation(self, instance):
        response = super().to_representation(instance)
        response['user'] = CustomUserDetailsSerializer(instance.user).data
        return response


class DriverSerializer(serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = "__all__"


class resetpasswordSerializer(serializers.ModelSerializer):
    username = serializers.CharField(max_length=100)
    password = serializers.CharField(max_length=100)

    class Meta:
        model = CustomUser
        fields = ['username', 'password']

    def save(self):
        username = self.validated_data['username']
        password = self.validated_data['password']
        # filtering out whethere username is existing or not, if your username is existing then if condition will allow your username
        if CustomUser.objects.filter(username=username).exists():
            # if your username is existing get the query of your specific username
            user = CustomUser.objects.get(username=username)
        # then set the new password for your username
            user.set_password(password)
            user.save()
            return user
        else:
            raise serializers.ValidationError(
                {'error': 'please enter valid crendentials'})


