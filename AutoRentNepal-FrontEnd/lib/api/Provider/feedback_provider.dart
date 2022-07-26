import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackState with ChangeNotifier {
  Future<bool> FeedbackSubmit(String title) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/feedback/");
    //var url = Uri.parse("http://10.0.2.2:8000/dashboard/feedback/");
    final String? key = await secureStorage!.read(key: 'key');
    var reqHeader = {
      "Content-Type": "application/json",
      "Authorization": "Token $key",
    };
    var reqBody = json.encode({
      "title": title,
    });
    try {
      http.Response response = await http.post(
        realDeviceUrl,
        //url,
        headers: reqHeader,
        body: reqBody,
      );
      var decodeRes = json.decode(response.body) as Map;
      print(decodeRes);
      if (decodeRes['title'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error while submitting feedbacks.");
      print(e);
      return false;
    }
  }
}
