//import 'dart:html';

// import 'dart:html';

//import 'dart:io';

import 'package:auto_rent_nepal_fyp/api/storage.dart';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:localstorage/localstorage.dart';

class PostState with ChangeNotifier {
  final List<Profile> _users = [];
  //LocalStorage storage = LocalStorage("usertoken");
  String Email = "";
  String Password = "";
  String Username = "";
  // String homeIpAddress = "192.168.1.66";
  // String collegeIpAddress = "172.16.3.25";

  Future<bool> login(String email, String password) async {
    Email = email;
    Password = password;
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/auth/login/");
    var url = Uri.parse("http://10.0.2.2:8000/auth/login/");
    var reqHeader = {
      "Content-Type": "application/json",
    };
    var reqBody = json.encode({
      "email": email,
      "password": password,
    });
    try {
      http.Response response = await http.post(
        //url,
        realDeviceUrl,
        headers: reqHeader,
        body: reqBody,
      );
      if (response.statusCode == 200) {
        var decodeRes = json.decode(response.body);
        print(decodeRes);
        print('Response status: ${response.statusCode}');
        print('key = ${decodeRes['key']}');
        //Saved Token
        saveLogin('${decodeRes["key"]}');
        return true;
      }
      return false;
    } catch (e) {
      print("Error while login");
      print(e);
      return false;
    }
  }

  Future<bool> registration(
    String username,
    String fullName,
    String email,
    String phoneNumber,
    String password1,
    String password2,
  ) async {
    // Username = username;
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/auth/registration/");
    //var url = Uri.parse("http://10.0.2.2:8000/auth/registration/");
    var reqHeader = {
      "Content-Type": "application/json",
    };
    var reqBody = json.encode({
      "username": username,
      "email": email,
      "password1": password1,
      "password2": password2,
      "phone_number": phoneNumber,
      "full_name": fullName,
    });
    try {
      http.Response response = await http.post(
        realDeviceUrl,
        //url,
        headers: reqHeader,
        body: reqBody,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeRes = json.decode(response.body) as Map;
        print(decodeRes);
        print('key = ${decodeRes['key']}');
        return true;
      }
      print(response.statusCode);
      print(response.body);
      return false;

      // var decodeRes = json.decode(response.body) as Map;
      // print(decodeRes);
      // if (decodeRes['key'] != null) {
      //   print(decodeRes['key']);
      //   return true;
      // }
      // return false;
    } catch (e) {
      print("Error while register");
      print(e);
      return false;
    }
  }

  //***********************User Details ************************* */
  Future<Profile?> userDetail() async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/accounts/profile/");
    //var url = Uri.parse("http://10.0.2.2:8000/accounts/profile/");
    final String? key = await secureStorage!.read(key: 'key');
    //
    print(' The user of the token: $key');
    try {
      final response = await http.get(
        realDeviceUrl,
        // url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $key"
        },
      );
      if (response.statusCode == 200) {
        var decodeRes = Profile.fromJson(json.decode(response.body));
        print("response: ${decodeRes.runtimeType}");
        print(decodeRes);
        return decodeRes;
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
    //return CircularProgressIndicator();
  }

  List<Profile> get users {
    return [..._users];
  }

  //*********************UpdateUser********* */
  Future<bool> UserUpdate(
      String email, String phoneNumber, String fullName) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/accounts/updateuser/");
    // var url = Uri.parse("http://10.0.2.2:8000/accounts/updateuser/");
    final String? key = await secureStorage!.read(key: 'key');
    var reqBody = json.encode({
      "email": email,
      "phone_number": phoneNumber,
      "full_name": fullName,
    });
    //
    print(' The UpdateUser of the token: $key');
    try {
      http.Response response = await http.post(
        //url,
        realDeviceUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $key"
        },
        body: reqBody,
      );
      var decodeRes = json.decode(response.body) as Map;
      print(decodeRes);
      print("response: ${decodeRes.runtimeType}");
      if (decodeRes['key'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //********************RESET PASSWORD OR FORGOT PASSWORD*************************** */

  Future<bool> forgotPassword(String username, String password) async {
    Username = username;
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/accounts/resetpassword/");
    //  var url = Uri.parse("http://10.0.2.2:8000/accounts/resetpassword/");
    var reqHeader = {
      "Content-Type": "application/json",
    };
    var reqBody = json.encode({
      "username": username,
      "password": password,
    });
    try {
      http.Response response = await http.post(
        realDeviceUrl,
        // url,
        headers: reqHeader,
        body: reqBody,
      );
      var decodeRes = json.decode(response.body) as Map;
      print(decodeRes);
      if (decodeRes['data'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error while resetting the password.");
      print(e);
      return false;
    }
  }
}
