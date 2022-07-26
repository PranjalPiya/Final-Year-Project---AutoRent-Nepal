import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/brand_detail_screen.dart';
import 'package:auto_rent_nepal_fyp/models/brand.dart';
import 'package:auto_rent_nepal_fyp/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleBrand extends StatelessWidget {
  final Brand? brands;

  const SingleBrand({Key? key, this.brands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BrandDetailScreen.routeName, arguments: brands!.id);
        },
        child: Container(
          height: size.height * 2,
          width: size.width * 1,
          // margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),

            //image: NetworkImage(url),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade100, Colors.white],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: 'http://192.168.1.66:8000${brands!.image}',
            placeholder: (context, url) => LoadingIndicator.Wave(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
