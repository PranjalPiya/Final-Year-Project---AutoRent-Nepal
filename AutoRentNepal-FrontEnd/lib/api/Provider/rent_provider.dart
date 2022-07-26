import 'dart:convert';

import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/rent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RentState with ChangeNotifier {
  List<Rent> _rent = [];

  Future<void> getRentalHistory() async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/rent/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/cart/");
    final String? key = await secureStorage!.read(key: 'key');
    try {
      http.Response response = await http.get(realDeviceUrl, headers: {
        "Authorization": "token $key",
      });
      var data = json.decode(response.body) as Map;
      // print(data);
      List<Rent> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          Rent rent = Rent.fromJson(element);
          demo.add(rent);
        });
        _rent = demo;
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getoldOrders");
    }
  }

  List<Rent>? get rents {
    if (_rent != null) {
      return [..._rent];
    } else {
      return null;
    }
  }

  Future<void> deleteRentVehicle(int id) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/deleterent/");
    // var url = Uri.parse("http://10.0.2.2:8000/dashboard/deleteSingleCart/");
    final String? key = await secureStorage!.read(key: 'key');

    try {
      http.Response response = await http.post(realDeviceUrl,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $key"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getRentalHistory();
      }
      print(data['message']);
    } catch (e) {
      print("e The vehicle was not deleted from the cart");
      print(e);
    }
  }
}
