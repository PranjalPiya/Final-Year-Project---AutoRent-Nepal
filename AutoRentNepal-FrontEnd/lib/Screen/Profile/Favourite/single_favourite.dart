import 'package:auto_rent_nepal_fyp/Screen/Homepage/vehicle_details.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SingleFavouriteVehicle extends StatelessWidget {
  final int? id;
  final String? title;
  final String? image;
  final String? brand;
  final int? price;
  final bool? fav;
  const SingleFavouriteVehicle(
      {Key? key,
      this.id,
      this.title,
      this.image,
      this.brand,
      this.price,
      this.fav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(VehicleDetails.routeName, arguments: id);
      },
      child: Stack(
        //elevation: 10,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: size.height * 0.6,
            width: size.width * 0.6,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade800, Colors.blue.shade300],
                )),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '$brand\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      )),
                  TextSpan(
                      text: '${title!}\n',
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 1.1)),
                ]),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 20 / 20,
            right: 20,
            child: Container(
              //tag: id!,
              child: CachedNetworkImage(
                imageUrl: "$image",
                progressIndicatorBuilder: (context, url, progress) =>
                    const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: SpinKitCircle(
                    color: AppColor.RED,
                  ),
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.error),
                  // backgroundImage: AssetImage('images/no_profile.jpg'),
                ),
                // imageBuilder: (con, imageprov) => CircleAvatar(
                //   radius: 60,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         //shape: BoxShape.valu,
                //         image: DecorationImage(
                //       image: imageprov,
                //       fit: BoxFit.fill,
                //     )),
                //   ),
                // ),
                height: 100,
                width: 220,
              ),
            ),
          ),
          // Positioned(
          //   top: 70,
          //   left: -100 / 20,
          //   child: Container(
          //     //tag: id!,
          //     child: CachedNetworkImage(
          //       imageUrl: "$image",
          //       placeholder: (context, url) => LoadingIndicator.Wave(),
          //       errorWidget: (context, url, error) => const Icon(Icons.error),
          //       height: size.height * 0.11,
          //       width: size.width * 0.43,
          //     ),
          //   ),
          // ),
          Positioned(
            top: 150,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Per Day\n',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: '\u{20B9}$price',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    //  GridTile(
    //   child: GestureDetector(
    //     onTap: () {
    //       print('working fine');
    //       // Navigator.of(context).push(MaterialPageRoute(
    //       //     builder: (context) => const VehicleDetailsScreen()));
    //       Navigator.of(context)
    //           .pushNamed(VehicleDetails.routeName, arguments: id);
    //     },
    //     child: Image.network(
    //       "http://10.0.2.2:8000$image",
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   footer: GridTileBar(
    //     backgroundColor: Colors.blue[500],
    //     title: Text(
    //       title!,
    //       style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 20)),
    //     ),
    //   ),
    // );
  }
}
