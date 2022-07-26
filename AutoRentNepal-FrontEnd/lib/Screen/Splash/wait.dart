import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/Screen/Splash/welcome.dart';
import 'package:auto_rent_nepal_fyp/api/storage.dart';
import 'package:flutter/material.dart';

class WaitTokenCheck extends StatelessWidget {
  const WaitTokenCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          // ignore: avoid_print
          print('Token Key is saved : ${snapshot.data}');

          if (snapshot.data != null) {
            return const LandingPage();
          }
          return const WelcomeScreen();
        },
        future: checkToken(),
      ),
    );
  }
}
