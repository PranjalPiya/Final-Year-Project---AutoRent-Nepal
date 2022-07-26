import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_screen.dart';
import 'package:auto_rent_nepal_fyp/api/driver_api.dart';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DriverDetailsScreen extends StatelessWidget {
  static const routeName = '/drivers-detail-screens';
  const DriverDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments;

    final driverDetails =
        Provider.of<DriverState>(context).singleDriver(id as int);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue.shade800,
          centerTitle: true,
          title: Column(
            children: [
              const Text("Details",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("${driverDetails!.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CachedNetworkImage(
                imageUrl:
                    'http://${URL.homeIpAddress}:8000${driverDetails.image}',
                progressIndicatorBuilder: (context, url, progress) => SizedBox(
                  height: 50,
                  // backgroundColor: Colors.transparent,
                  child: const SpinKitCircle(
                    color: AppColor.RED,
                  ),
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/no_profile.jpg'),
                ),
                imageBuilder: (con, imageprov) => SizedBox(
                  height: size.height * 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageprov,
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: Container(
                  child: Text(
                    '${driverDetails.name}',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const Text(
                'Occupation:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: Text(
                  'Driver',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    //  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Age:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${driverDetails.age}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Phone:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${driverDetails.phone}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'About ${driverDetails.name}:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                child: Text(
                  "${driverDetails.about}",
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
