import 'package:auto_rent_nepal_fyp/Screen/Homepage/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleAdvertise extends StatelessWidget {
  final int? id;
  final String? title;
  final String? image;
  const SingleAdvertise({Key? key, this.id, this.title, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GridTile(
        child: GestureDetector(
          onTap: () {
            print('working fine');
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => const VehicleDetailsScreen()));
            Navigator.of(context)
                .pushNamed(VehicleDetails.routeName, arguments: id);
          },
          child: Image.network(
            "$image",
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
        // footer: GridTileBar(
        //   trailing: const Icon(
        //     Icons.arrow_forward_ios,
        //     color: Colors.black,
        //   ),
        //   //backgroundColor: Colors.blue[500],
        //   backgroundColor: Colors.grey[200],
        //   title: Text(
        //     title!,
        //     style: GoogleFonts.ubuntu(
        //         textStyle: const TextStyle(fontSize: 20, color: Colors.black)),
        //   ),
        // ),
      ),
    );
  }
}
