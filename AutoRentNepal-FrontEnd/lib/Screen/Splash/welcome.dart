import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Registration/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.height * 0.05,
              right: size.height * 0.05,
              top: size.height * 0.05,
              bottom: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //**************************Welcome To************ */
              Text(
                'Welcome to',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              //********************Text AutoRent************8 */
              Text(
                'AutoRent Nepal',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
              //******************************** */
              SizedBox(
                height: size.height * 0.02,
              ),
              //****************Text**************** */
              Text(
                'Namaste..! Welcome to the AutoRent Nepal where you can easily rent the vehicle you want.',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Image.asset(
                'images/welcome2.jpg',
                height: 300,
                width: 300,
              ),
              //********************************************* */
              SizedBox(
                height: size.height * 0.04,
              ),
              //**************Login Button****************** */
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.roboto(fontSize: size.width * 0.05),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[800],
                  elevation: 10,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              //********************************************** */
              SizedBox(
                height: size.height * 0.04,
              ),
              //**************Register Button****************** */
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: Text(
                  'Register',
                  style: GoogleFonts.roboto(fontSize: size.width * 0.05),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[800],
                  //primary: Colors.red[700],
                  elevation: 10,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
