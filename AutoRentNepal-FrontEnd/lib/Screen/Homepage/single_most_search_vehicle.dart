import 'package:auto_rent_nepal_fyp/Screen/Homepage/most_search_vehicles_details.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/vehicle_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleMostSearchVehicle extends StatelessWidget {
  final int? id;
  final String? brand;
  final String? title;
  final String? image;
  final int? price;
  final bool? fav;
  const SingleMostSearchVehicle(
      {Key? key,
      this.id,
      this.brand,
      this.title,
      this.image,
      this.price,
      this.fav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MostSearchVehicless.routeName, arguments: id);
      },
      child: Stack(
        //elevation: 10,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 280,
            width: 215,
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
                      text: '${brand!}\n',
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
            child: Container(
              //tag: id!,
              child: CachedNetworkImage(
                imageUrl: "$image",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 100,
                width: 220,
              ),
            ),
          ),

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
                          text: '\u{20B9}${price!}',
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

          // Container(
          //   //height: 50,
          //   width: 200,
          //   margin: const EdgeInsets.all(10),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // Text("${vehicle[i].rentalPrice}"),
          //       Image.network(
          //         "http://10.0.2.2:8000$image",
          //         height: 100,
          //         width: 150,
          //       ),
          //       SizedBox(
          //         height: size.height * 0.03,
          //       ),
          //       Text(
          //         title!,
          //         style: GoogleFonts.roboto(
          //           fontSize: 20,
          //         ),
          //       ),
          //       Container(
          //         padding: const EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           color: Colors.blue[600],
          //         ),
          //         child: Text('${price}'),

          //         // margin: EdgeInsets.all(10),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
