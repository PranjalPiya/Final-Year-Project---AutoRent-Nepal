import 'dart:convert';

import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:flutter/material.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/advertise.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AdvertiseState with ChangeNotifier {
  List<Advertise> _advertise = [];

  Future<bool> getAdvertise() async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/advertise/");
    // var url = Uri.parse("http://10.0.2.2:8000/dashboard/advertise/");
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
      List<Advertise> temp = [];
      for (var element in decodeRes) {
        Advertise advertise = Advertise.fromJson(element);
        temp.add(advertise);
      }
      _advertise = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error while getting advertise ');
      return false;
    }
  }

  List<Advertise> get advertise {
    return [..._advertise];
  }
}
