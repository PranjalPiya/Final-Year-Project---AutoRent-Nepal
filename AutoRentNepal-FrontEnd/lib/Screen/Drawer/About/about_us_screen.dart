import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = 'about-us-screen';
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.grey.shade300,
        //const Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            Positioned(
              top: 230,
              left: 12,
              right: 12,
              child: Container(
                // padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'OVERVIEW'.toUpperCase(),
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 38.0,
                          color: const Color(0xff00c6ff)),
                      const Text(
                          'AutoRent Nepal, which was founded on 2018 has been providing their best services to the people of Kathmandu. Our main goal is to providing quality services to our customer.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400)),
                      //
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      Text(
                        'Our Services'.toUpperCase(),
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 38.0,
                          color: const Color(0xff00c6ff)),
                      const Text(
                          'If you are looking for the reliable online vehicle rental company in Nepal then AutoRent Nepal should definitely be your choise. Our services are:\n\n \u2022 We provide luxurious and comfortable transportation.\n\n \u2022 We have a driver who is familiar with the Nepal tour and trekking destinations.\n\n \u2022 We have a team with years of experience.\n\n \u2022 We provide online vehicle rental services and accept payments via the internet.\n\n \u2022 We provide you a fair pricing and the best value for your money.  ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'images/jeep_mountain.jpg',
          ),
          colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 86, 119, 190).withOpacity(.7),
              BlendMode.hardLight),
          fit: BoxFit.cover,
        ),
      ),
      constraints: const BoxConstraints.expand(height: 225.0),
    );
  }

  Container _getGradient() {
    return Container(
      margin: const EdgeInsets.only(top: 130.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            const Color(0x00736AB7), Colors.grey.shade300,

            //Color(0xFF736AB7),
          ],
          stops: const [0.0, 0.8],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return Container(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _overviewTitle,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: const Color(0xff00c6ff)),
            const Text(
                'Lorem hsjjjjjjjsdhfjsdhfjshffffffdjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',
                style: TextStyle(
                    color: Color(0xffb6b2df),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: const BackButton(color: Colors.white),
    );
  }
}
