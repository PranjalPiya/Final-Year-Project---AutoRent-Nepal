import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/About/about_us_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/HelpAndSupport/help_and_support_screen.dart';

import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/rental_history.dart';
import 'package:auto_rent_nepal_fyp/api/storage.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  _logoutnow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("LOGOUT"),
          content: const Text('Do you really want to Logout..?'),
          actions: [
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                deleteLogin();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Ok"),
            ),
            RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.WHITE,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    child: Image.asset(
                      'images/autorent_nepal_logo1.png',
                      height: 110,
                      width: 105,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'AutoRent Nepal \n',
                            style: GoogleFonts.oswald(
                                letterSpacing: 1,
                                color: AppColor.BLACK,
                                fontSize: 40)),
                        TextSpan(
                            text: '    The rental services since 2022',
                            style: GoogleFonts.ubuntu(
                              color: AppColor.BLACK,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
                title: const Text("Home"),
                trailing: const Icon(
                  Icons.home,
                  color: AppColor.BLACK,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(LandingPage.routeName);

                  print('Home is working perfectly');
                }),
            //*********************** */
            ListTile(
                title: const Text("Drivers"),
                trailing: const Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(DriverScreen.routeName);
                  //_logoutnow();
                  print('Driver is working perfectly');
                }),

            ListTile(
                title: const Text("Rental History"),
                trailing: const Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RentalHistory()));

                  print('Logout is working perfectly');
                }),
            const Divider(
              color: AppColor.BLACK,
              thickness: 1,
            ),
            //******************* */
            ListTile(
                title: const Text("About Us"),
                trailing: const Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AboutUsScreen.routeName);
                  // _logoutnow();
                  print('Logout is working perfectly');
                }),
            //**************** */
            ListTile(
                title: const Text("Help & Support"),
                trailing: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(HelpAndSupportScreen.routeName);
                  //_logoutnow();
                  print('Logout is working perfectly');
                }),
            //**************** */
            ListTile(
                title: const Text("Logout"),
                trailing: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onTap: () {
                  _logoutnow();
                  print('Logout is working perfectly');
                }),
          ],
        ),
      ),
    );
  }
}
