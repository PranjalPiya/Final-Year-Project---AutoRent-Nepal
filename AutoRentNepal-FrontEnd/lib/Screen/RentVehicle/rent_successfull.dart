import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentSuccessfulScreen extends StatelessWidget {
  static const routeName = 'rent-successfull-screen';
  const RentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Image.asset(
                    'images/welcome.png',
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  child: Text(
                    'Congratulation...!',
                    style: GoogleFonts.oswald(
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'You have successfully rented the vechicle. Our team member will contact to you as soon as possible.',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LandingPage.routeName);
                  },
                  child: Text(
                    'Go to Homepage',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    elevation: 10,
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
