import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Registration/signup_form.dart';
import 'package:auto_rent_nepal_fyp/Screen/Splash/welcome.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//SignUpScreen
class SignUpScreen extends StatelessWidget {
  static const routeName = '/registration-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: size.height * 0.29,
                  width: size.width,
                  decoration: BoxDecoration(
                      //color: const Color(0xff3b5999).withOpacity(.7),
                      image: DecorationImage(
                    image:
                        const AssetImage('images/nepal_mountain_vehicle.jpg'),
                    colorFilter: ColorFilter.mode(
                        const Color(0xff3b5999).withOpacity(.7),
                        BlendMode.hardLight),
                    fit: BoxFit.fill,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();

                                print('Arrow is clicked');
                              },
                            ),
                            //********************Logo***************** */
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                'images/autorent_nepal_logo1.png',
                                height: 50,
                                alignment: Alignment.topRight,
                                width: 145,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        //*******************Richtext for registration */
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Registration \n',
                                  style: GoogleFonts.oswald(
                                      letterSpacing: 1, fontSize: 50)),
                              TextSpan(
                                  text: 'Provide your credintials to register.',
                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
