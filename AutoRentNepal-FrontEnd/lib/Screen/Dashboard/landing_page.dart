import 'dart:io';
import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/explore.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/homepage.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/profile_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/SearchPage/search.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
//import 'package:upgrader/upgrader.dart';

class LandingPage extends StatefulWidget {
  final pos;
  static const routeName = '/landing-screen';
  const LandingPage({Key? key, this.pos}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  int? position = 0;
  TabController? pageController;

  @override
  void initState() {
    if (widget.pos != null) {
      position = widget.pos;
    }
    pageController =
        TabController(length: 4, vsync: this, initialIndex: position!);
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exit(0);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            Homepage(
              title: 'Homepage',
            ),
            SearchVehicle(
              title: 'SearchVehicle',
            ),
            ExploreVehicle(title: 'Explore Vehicle'),
            ProfileScreen(
              title: 'Profile',
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(Icons.home, color: AppColor.WHITE),
            Icon(
              Icons.search,
              color: AppColor.WHITE,
            ),
            Icon(Icons.explore, color: AppColor.WHITE),
            Icon(Icons.person, color: AppColor.WHITE)
          ],
          //backgroundColor: AppColor.WHITE,
          height: 60,
          backgroundColor: Colors.transparent,
          color: Colors.blue.shade800,
          //color: Colors.blue.shade400,
          buttonBackgroundColor: Colors.blue.shade800,

          index: position!,
          onTap: (i) {
            // play();
            setState(() {
              position = i;
              pageController!.animateTo(position!,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500));
            });
          },
        ),
      ),
    );
  }
}
