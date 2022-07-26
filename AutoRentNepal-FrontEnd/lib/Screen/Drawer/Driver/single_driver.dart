import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/driver_details_screen.dart';
import 'package:auto_rent_nepal_fyp/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singleDriver extends StatelessWidget {
  final int? id;
  final String? name;
  final String? image;
  final String? phone;
  final String? about;
  final String? age;
  const singleDriver(
      {Key? key,
      this.id,
      this.name,
      this.image,
      this.phone,
      this.about,
      this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DriverDetailsScreen.routeName, arguments: id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListTile(
          leading: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: "http://192.168.1.66:8000$image",
            placeholder: (context, url) => LoadingIndicator.Wave(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (con, imageprov) => CircleAvatar(
              radius: 50,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageprov,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            height: 50,
            width: 50,
          ),
          title: Text(
            '$name',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Age: $age',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
