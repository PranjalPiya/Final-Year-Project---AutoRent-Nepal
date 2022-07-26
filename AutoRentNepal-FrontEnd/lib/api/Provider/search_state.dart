import 'dart:convert';

import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/models/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

class SearchState with ChangeNotifier {
  List<Search> _search = [];
  Future<List<Search>?> getSearchDetails({String? q = ""}) async {
    var realDeviceUrl =
        Uri.parse("http://${URL.homeIpAddress}:8000/dashboard/search/$q/");

    try {
      http.Response response = await http.get(
        //url,
        realDeviceUrl,
      );
      if (response.statusCode == 200) {
        final decodeRes = jsonDecode(response.body);
        final searchList = decodeRes['vehicles'] as List;
        print(searchList);
        List<Search> temp = [];
        for (var element in searchList) {
          Search search = Search.fromJson(element);
          temp.add(search);
        }
        _search = temp;
        notifyListeners();
        return searchList.map((data) => Search.fromJson(data)).toList();
      }
    } catch (e) {
      print("error while getting search of Vehicles");
      print(e);
    }
    return null;
  }

  List<Search> get searchessss {
    return [..._search];
  }
}
