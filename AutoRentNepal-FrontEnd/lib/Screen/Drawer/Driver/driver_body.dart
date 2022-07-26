//import 'dart:html';

import 'package:auto_rent_nepal_fyp/Screen/Drawer/Driver/single_driver.dart';

import 'package:auto_rent_nepal_fyp/api/driver_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverBody extends StatefulWidget {
  const DriverBody({Key? key}) : super(key: key);

  @override
  _DriverBodyState createState() => _DriverBodyState();
}

class _DriverBodyState extends State<DriverBody> {
  bool init = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (init) {
      // ProfileResponse = Provider.of<PostState>(context).userDetail();
      isLoading = await Provider.of<DriverState>(context, listen: false)
          .getDriverDetails();

      setState(() {});
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //List<Driver?> drivers;
    Size size = MediaQuery.of(context).size;
    final drivers = Provider.of<DriverState>(context).driverssss;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.blue.shade700,
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: const [
                  Text("Driver's",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white)),
                  Text("Available",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white))
                ],
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                _listViewDriver(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listViewDriver() {
    final drivers = Provider.of<DriverState>(context).driverssss;

    return ListView.builder(
        shrinkWrap: true,
        //scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drivers.length,
        itemBuilder: (ctx, i) {
          return singleDriver(
            id: drivers[i].id,
            name: drivers[i].name,
            age: drivers[i].age,
            phone: drivers[i].phone,
            about: drivers[i].about,
            image: drivers[i].image,
          );
        });
  }
}
