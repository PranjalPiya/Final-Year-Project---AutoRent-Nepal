import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_body.dart';
import 'package:flutter/material.dart';

class DriverScreen extends StatelessWidget {
  static const routeName = '/Driver-screen';
  const DriverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DriverBody(),
    );
  }
}
