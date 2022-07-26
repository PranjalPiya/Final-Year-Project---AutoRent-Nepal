import 'dart:convert';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/cart.dart';
import 'package:auto_rent_nepal_fyp/models/rent.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartState with ChangeNotifier {
  Cart? _cart;
  //Rent? _rent;
  final List<Rent> _rent = [];

  Future<void> getCartData() async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/cart/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/cart/");
    final String? key = await secureStorage!.read(key: 'key');
    try {
      http.Response response = await http.get(
        //url,
        realDeviceUrl,
        headers: {"Authorization": "Token $key"},
      );
      var data = json.decode(response.body) as Map;
      print(data['error']);
      List<Cart> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          Cart cartModel = Cart.fromJson(element);
          demo.add(cartModel);
        });
        _cart = demo[0];
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      print("error getCartDatas");
    }
  }

  Cart? get cart {
    if (_cart != null) {
      return _cart;
    } else {
      return null;
    }
  }

  //
  Future<void> addtoCart(int id) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/addtocart/");
    // var url = Uri.parse("http://10.0.2.2:8000/dashboard/addtocart/");
    final String? key = await secureStorage!.read(key: 'key');

    try {
      http.Response response = await http.post(
          //url,
          realDeviceUrl,
          body: json.encode({
            'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $key"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        //getCartDatas();
        getCartData();
      }
    } catch (e) {
      print("e addtoCart");
      print(e);
    }
  }

  Future<void> deleteVehicleCart(int id) async {
    var realDeviceUrl = Uri.parse(
        "http://${URL.homeIpAddress}:8000/dashboard/deleteSingleCart/");
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
        getCartData();
      }
      print(data['message']);
    } catch (e) {
      print("e The vehicle was not deleted from the cart");
      print(e);
    }
  }

  Future<bool> deletecart(int id) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/deleteAllCart/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/deleteAllCart/");
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
        getCartData();
        _cart = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e Cart was not deleted");
      print(e);

      return false;
    }
  }

  List<Rent>? get rents {
    if (_rent != null) {
      return [..._rent];
    } else {
      return null;
    }
  }
}
