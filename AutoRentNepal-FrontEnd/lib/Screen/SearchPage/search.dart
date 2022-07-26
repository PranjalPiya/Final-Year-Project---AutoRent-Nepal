import 'package:auto_rent_nepal_fyp/Screen/SearchPage/search_body.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';

class SearchVehicle extends StatelessWidget {
  static const routeName = '/SearchVehicle-screen';
  // ignore: prefer_typing_uninitialized_variables
  final title;
  const SearchVehicle({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchBody();
  }
}
