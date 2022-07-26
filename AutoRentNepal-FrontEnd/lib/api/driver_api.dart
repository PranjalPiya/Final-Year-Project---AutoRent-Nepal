import 'dart:convert';
// import 'dart:ffi';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:collection/collection.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/single_driver.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/driver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriverState with ChangeNotifier {
  List<Driver> _drivers = [];
  Future<bool> getDriverDetails() async {
    //Search result;
    final String? key = await secureStorage!.read(key: 'key');
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/accounts/driver/");
    // var url = Uri.parse('http://10.0.2.2:8000/accounts/driver/');
    try {
      http.Response response = await http.get(
        realDeviceUrl,
        // url,
        headers: {'Authorization': 'Token $key'},
      );
      //if (response.statusCode == 200) {
      var decodeRes = jsonDecode(response.body) as List;
      print(decodeRes);
      List<Driver> temp = [];
      for (var element in decodeRes) {
        Driver driver = Driver.fromJson(element);
        temp.add(driver);
      }
      _drivers = temp;
      notifyListeners();
      return true;
      //Driver.fromJson(decodeRes);
      // }
      //return true;
    } catch (e) {
      print("error while getting search of Vehicles");
      print(e);
      return false;
    }
    // return false;
  }

  List<Driver> get driverssss {
    return [..._drivers];
  }

  Driver? singleDriver(int id) {
    return _drivers.firstWhereOrNull((a) => a.id == id);
  }
}
