import 'dart:async';
import 'package:auto_rent_nepal_fyp/Screen/Splash/wait.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_gridview_app/constant/Constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _visible = true;
  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () =>
          //navigationPage(),
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const WaitTokenCheck())),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: SpinKitChasingDots(
                  color: Colors.blue.shade800,
                  size: 60,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: AppColor.BLACK,
                          fontSize: 15,
                        ),
                      ),
                      children: const [
                        //*************** */
                        TextSpan(
                            text: '2022 \u00a9 ',
                            style: TextStyle(
                              fontSize: 23,
                            )),
                        //*********** */
                        TextSpan(
                          text: 'AutoRent Nepal',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                "Developed by Pranjal Piya",
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/autorent_nepal_logo.png',
                  height: 500,
                  width: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
