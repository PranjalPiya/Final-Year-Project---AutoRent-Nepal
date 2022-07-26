import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/rent_vehicle_screen.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleCart extends StatelessWidget {
  final int? id;
  final String? image;
  final String? title;
  final int? price;
  const SingleCart({Key? key, this.id, this.image, this.title, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: "http://192.168.1.66:8000${image}",
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
                    Text(
                      "${title}",
                      style: GoogleFonts.oswald(
                        fontSize: 26,
                      ),
                    ),

                    Text(
                      "Rs.${price}/Day",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue.shade100,
                      onPressed: () {
                        // Provider.of<CartState>(context, listen: false)
                        //     .deleteVehicleCart(id!);
                        Navigator.of(context).pushNamed(
                          RentVehicleScreen.routeName,
                          arguments: id,
                        );
                        // Provider.of<CartState>(context,
                        //         listen: false)
                        //     .deleteVehicleCart(item.id!);
                      },
                      child: const Text("Rent"),
                    )

                    // Text(
                    //   "Quantity : ${item.quntity}",
                    //   style: GoogleFonts.roboto(
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            // RaisedButton(
            //   color: Colors.greenAccent,
            //   onPressed: () {
            //     Provider.of<CartState>(context, listen: false)
            //         .deleteVehicleCart(item.id!);
            //   },
            //   child: Text("Delate"),
            // )
          ],
        ),
      ),
    );
  }
}
