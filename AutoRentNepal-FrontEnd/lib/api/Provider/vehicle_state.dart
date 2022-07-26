import 'dart:convert';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/models/brand.dart';
import 'package:auto_rent_nepal_fyp/models/most_search_vehicle.dart';
import 'package:auto_rent_nepal_fyp/models/popular.dart';
import 'package:collection/collection.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/Vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleState with ChangeNotifier {
  //*********API CALL FOR GETTING BRANDS*************** */
  List<Brand> _brand = [];

  Future<void> getBrandDetails() async {
    final String? key = await secureStorage!.read(key: 'key');
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/brand/");
    //var url = Uri.parse('http://10.0.2.2:8000/dashboard/brand/');
    try {
      http.Response response = await http.get(
        realDeviceUrl,
        headers: {'Authorization': 'Token $key'},
      );
      var data = json.decode(response.body) as List;
      //print(data);
      List<Brand> temp = [];
      for (var element in data) {
        Brand brand = Brand.fromJson(element);
        temp.add(brand);
      }
      _brand = temp;
      notifyListeners();
    } catch (e) {
      print("error while getting Brands of Vehicles");
      print(e);
    }
  }

  List<Brand>? get brand {
    return [..._brand];
    return null;
  }

  List<Vehicle> brandVehicle(int id) {
    return [..._vehicles.where((element) => element.Brand!.id == id)];
  }

//**********************GET VEHICLE****************************** */
  List<Vehicle> _vehicles = [];

  Future<bool> getVehicles() async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/vehicle/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/vehicle/");
    final String? key = await secureStorage!.read(key: 'key');

    print(' Vehicle is ready for this token: $key');

    try {
      http.Response response = await http.get(
        // url,
        realDeviceUrl,
        headers: {"Authorization": "Token $key"},
      );

      var decodeRes = json.decode(response.body) as List;
      //print(decodeRes);
      List<Vehicle> temp = [];
      for (var element in decodeRes) {
        Vehicle vehicle = Vehicle.fromJson(element);
        temp.add(vehicle);
      }
      _vehicles = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error while getting vehicle');
      return false;
    }
  }

  //*******************Popular Vehicle API******************** */
  List<Popular> _popularVehicles = [];

  Future<bool> getPopularVehicles() async {
    var realDeviceUrl = Uri.parse(
        "http://${URL.homeIpAddress}:8000/dashboard/popularvehicles/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/popularvehicles/");
    final String? key = await secureStorage!.read(key: 'key');
    print(' Vehicle is ready for this token: $key');
    try {
      http.Response response = await http.get(
        //url,
        realDeviceUrl,
        headers: {"Authorization": "Token $key"},
      );
      var decodeRes = json.decode(response.body) as List;
      // print(decodeRes);
      List<Popular> temp = [];
      for (var element in decodeRes) {
        Popular popularVehicle = Popular.fromJson(element);
        temp.add(popularVehicle);
      }
      _popularVehicles = temp;
      // getVehicles();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error while getting popularvehicle');
      return false;
    }
  }

  //*******************MOST Searched Vehicles***************************** */
  List<MostSearchVehicle> _mostsearchvehicle = [];

  Future<bool> getMostSearchVehicle() async {
    var realDeviceUrl = Uri.parse(
        "http://${URL.homeIpAddress}:8000/dashboard/mostsearchedvehicles/");
    final String? key = await secureStorage!.read(key: 'key');
    print(' MostSearchedVehicle is ready for this token: $key');
    try {
      http.Response response = await http.get(
        //url,
        realDeviceUrl,
        headers: {"Authorization": "Token $key"},
      );

      var decodeRes = json.decode(response.body) as List;
      //print(decodeRes);
      List<MostSearchVehicle> temp = [];
      for (var element in decodeRes) {
        MostSearchVehicle mostSearchVehicle =
            MostSearchVehicle.fromJson(element);
        temp.add(mostSearchVehicle);
      }
      _mostsearchvehicle = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error while getting vehicle');
      return false;
    }
  }

  //****************Favourite button***************** */
  Future<void> favouriteButton(int id) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/favourite/");
    final String? key = await secureStorage!.read(key: 'key');
    try {
      http.Response response = await http.post(
        //url,
        realDeviceUrl,
        body: json.encode(
          {
            'id': id,
          },
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $key"
        },
      );
      var decodeRes = json.decode(response.body);
      print(decodeRes);
      getVehicles();
      //getPopularVehicles();
    } catch (e) {
      print('Error while getting favourite');
    }
  }

//******************Vehicle list************************* */
  List<Vehicle> get vehicles {
    return [..._vehicles];
  }

//***************PopularVehicle List************* */
  List<Popular> get popularVehicles {
    return [..._popularVehicles];
  }

  List<MostSearchVehicle> get mostSearchVehicles {
    return [..._mostsearchvehicle];
  }

//************************************* */
  List<Vehicle> get favourites {
    return _vehicles.where((element) => element.favourite == true).toList();
  }

//**************************************** */
  Vehicle? singleVehicle(int id) {
    return _vehicles.firstWhereOrNull((a) => a.id == id);
  }

  // Vehicle? singleFavVehicle(int id) {
  //   return _vehicles.firstWhereOrNull((a) => a.id == id);
  // }

  Popular? listViewVehicle(int id) {
    return _popularVehicles.firstWhereOrNull((a) => a.id == id);
  }

  MostSearchVehicle? singleMostSearchV(int id) {
    return _mostsearchvehicle.firstWhereOrNull((a) => a.id == id);
  }
}
