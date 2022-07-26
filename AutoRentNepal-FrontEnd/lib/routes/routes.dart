//import 'dart:js';

//import 'dart:js';

// import 'dart:js';

import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/About/about_us_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_details_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/HelpAndSupport/help_and_support_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/brand_detail_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/explore.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/most_search_vehicles_details.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/popular_vehicles_details.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/vehicle_details.dart';
import 'package:auto_rent_nepal_fyp/Screen/Login/ForgetPassword/forgot_password_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Notification/notification_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Cart/cart_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/Favourite/favourite_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/edit_profile.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/profile_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/homepage.dart';
import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/rental_history.dart';
import 'package:auto_rent_nepal_fyp/Screen/Registration/signup_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/rent_successfull.dart';
import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/rent_vehicle_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/SearchPage/search.dart';
import 'package:auto_rent_nepal_fyp/Screen/Splash/welcome.dart';

import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  AboutUsScreen.routeName: (context) => const AboutUsScreen(),
  HelpAndSupportScreen.routeName: (context) => const HelpAndSupportScreen(),
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  FavouriteScreen.routeName: (context) => const FavouriteScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  LandingPage.routeName: (context) => const LandingPage(),
  Homepage.routeName: (context) => const Homepage(),
  SearchVehicle.routeName: (context) => const SearchVehicle(),
  ExploreVehicle.routeName: (context) => const ExploreVehicle(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  DriverScreen.routeName: (context) => const DriverScreen(),
  DriverDetailsScreen.routeName: (context) => const DriverDetailsScreen(),
  BrandDetailScreen.routeName: (context) => const BrandDetailScreen(),
  VehicleDetails.routeName: (context) => const VehicleDetails(),
  CartScreen.routeName: (context) => const CartScreen(),
  RentVehicleScreen.routeName: (context) => const RentVehicleScreen(),
  RentalHistory.routeName: (context) => const RentalHistory(),
  PopularVehicleDetail.routeName: (context) => const PopularVehicleDetail(),
  EditProfile.routeName: (context) => EditProfile(),
  MostSearchVehicless.routeName: (context) => const MostSearchVehicless(),
  PushNotificationScreen.routeName: (context) => const PushNotificationScreen(),
  RentSuccessfulScreen.routeName: (context) => const RentSuccessfulScreen(),
};
