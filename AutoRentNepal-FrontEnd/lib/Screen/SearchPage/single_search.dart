import 'package:auto_rent_nepal_fyp/Screen/Homepage/vehicle_details.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleSearchVehicle extends StatelessWidget {
  final String? brand;
  final String? title;
  final String? image;
  final int? id;
  final int? price;
  const SingleSearchVehicle(
      {Key? key, this.brand, this.title, this.id, this.price, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(VehicleDetails.routeName, arguments: id);
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: "$image",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      child: SpinKitCircle(
                        color: AppColor.RED,
                      ),
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('images/autorent_nepal_logo.png'),
                    ),
                    imageBuilder: (con, imageprov) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageprov,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "$title",
                        style: GoogleFonts.oswald(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "$brand",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("\u{20B9}$price/Day",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
