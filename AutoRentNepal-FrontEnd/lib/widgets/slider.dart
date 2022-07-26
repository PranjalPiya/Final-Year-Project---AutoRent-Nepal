import 'package:auto_rent_nepal_fyp/Screen/Homepage/singleAdvertise.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/advertise_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:provider/provider.dart';

class VehicleSlider extends StatefulWidget {
  const VehicleSlider({Key? key}) : super(key: key);

  @override
  State<VehicleSlider> createState() => _VehicleSliderState();
}

class _VehicleSliderState extends State<VehicleSlider> {
  @override
  Widget build(BuildContext context) {
    final advertise = Provider.of<AdvertiseState>(context).advertise;

    return Center(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        itemCount: advertise.length,
        itemBuilder: (context, index, realIndex) => Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleAdvertise(
                id: advertise[index].id,
                title: advertise[index].title,
                image: advertise[index].image,
              )),
        ),
      ),
    );
  }
}
