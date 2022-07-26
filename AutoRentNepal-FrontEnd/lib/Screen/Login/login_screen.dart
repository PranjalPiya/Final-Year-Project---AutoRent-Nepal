import 'package:auto_rent_nepal_fyp/Screen/Login/login_form.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        //backgroundColor: Colors.green[100],
        // backgroundColor: AppColor.CREAM,
        body:
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 300,
            //         child: Stack(
            //           children: [
            //             //************For upper part */
            //             Positioned(
            //                 top: 0,
            //                 left: 0,
            //                 right: 0,
            //                 child: Container(
            //                   height: 300,
            //                   decoration: const BoxDecoration(
            //                       image: DecorationImage(
            //                           image: AssetImage(
            //                               "images/nepal_temple_mountain.jpg"),
            //                           fit: BoxFit.fill)),
            //                   child: Container(
            //                     //padding: const EdgeInsets.all(10),
            //                     color: Color(0xff3b5999).withOpacity(.7),
            //                     child: Padding(
            //                       padding:
            //                           const EdgeInsets.only(left: 20, right: 20),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           //
            //                           Align(
            //                             alignment: Alignment.topRight,
            //                             child: Image.asset(
            //                               'images/autorent_nepal_logo1.png',
            //                               height: size.height * 0.15,
            //                               alignment: Alignment.topRight,
            //                               width: size.width,
            //                             ),
            //                           ),
            //                           //
            //                           RichText(
            //                             text: TextSpan(
            //                               children: [
            //                                 TextSpan(
            //                                     text: 'Login \n',
            //                                     style: GoogleFonts.oswald(
            //                                         letterSpacing: 1,
            //                                         //color: Colors.black,
            //                                         fontSize: 60)),
            //                                 TextSpan(
            //                                     text:
            //                                         'Provide your login credintials to login',
            //                                     style: GoogleFonts.ubuntu(
            //                                       //color: Colors.black,
            //                                       fontSize: 20,
            //                                     )),
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 )),
            //             //*************** */
            //             // Positioned(
            //             //     top: 250,
            //             //     bottom: 0,
            //             //     child: Container(
            //             //       height: 400,
            //             //       width: size.width - 40,
            //             //       margin: const EdgeInsets.symmetric(horizontal: 20),
            //             //       decoration: BoxDecoration(
            //             //           color: Colors.white,
            //             //           borderRadius: BorderRadius.circular(15),
            //             //           boxShadow: [
            //             //             BoxShadow(
            //             //               color: Colors.black.withOpacity(0.3),
            //             //               blurRadius: 15,
            //             //               spreadRadius: 5,
            //             //             )
            //             //           ]),
            //             //       //child: const LoginScreen(),
            //             //     ))
            //           ],
            //         ),
            //       ),
            //       //const LoginScreen(),
            //     ],
            //   ),
            // )
            SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  //color: const Color(0xff3b5999).withOpacity(.7),
                  height: 270,
                  width: size.width,
                  decoration: BoxDecoration(
                      //color: const Color(0xff3b5999).withOpacity(.7),
                      image: DecorationImage(
                    image: const AssetImage('images/nepal_temple_mountain.jpg'),
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
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'images/autorent_nepal_logo.png',
                            height: 50,
                            alignment: Alignment.topRight,
                            width: 145,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Login \n',
                                  style: GoogleFonts.oswald(
                                      letterSpacing: 1,
                                      //color: Colors.black,
                                      fontSize: 50)),
                              TextSpan(
                                  text:
                                      'Provide your login credintials to login',
                                  style: GoogleFonts.roboto(
                                    //color: Colors.black,
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
              // InkWell(
              //   child: const Icon(
              //     Icons.arrow_back_ios,
              //     size: 25,
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //     print('Arrow is clicked');
              //   },
              // ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Image.asset(
              //     'images/autorent_nepal_logo1.png',
              //     height: 100,
              //     alignment: Alignment.topRight,
              //     width: 145,
              //   ),
              // ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //           text: 'Login \n',
              //           style: GoogleFonts.oswald(
              //               letterSpacing: 1,
              //               color: Colors.black,
              //               fontSize: 50)),
              //       TextSpan(
              //           text: 'Provide your login credintials to login',
              //           style: GoogleFonts.ubuntu(
              //             color: Colors.black,
              //             fontSize: 17,
              //           )),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: size.height * 0.08,
              ),
              const LoginForm(),
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
