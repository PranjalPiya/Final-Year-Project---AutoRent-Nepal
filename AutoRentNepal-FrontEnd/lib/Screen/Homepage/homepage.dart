import 'package:auto_rent_nepal_fyp/Screen/Drawer/About/about_us_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Drawer/drawer.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/listview_vehicle.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/single_most_search_vehicle.dart';
import 'package:auto_rent_nepal_fyp/Screen/Cart/cart_screen.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/advertise_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/rent_provider.dart';

import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:auto_rent_nepal_fyp/Screen/Homepage/singleVehicle.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/models/profile.dart';
import 'package:auto_rent_nepal_fyp/models/pushnotification.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  final title;
  static const routeName = '/home-screen';
  const Homepage({Key? key, this.title}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool init = true;
  bool isLoading = false;
  //bool isLoad = false;
  var ProfileResponse;
  var popularV;
  String? searchVehicle;

  //*************FIREBASE CLOUD MESSAGING**************** */
  late final FirebaseMessaging _messaging;
  late int _totalNotificaitonCounter;
  Pushnotification? _pushnotification;

  void registerNotfication() async {
    await Firebase.initializeApp();
    //instance for firebase messaging
    _messaging = FirebaseMessaging.instance;
    //
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted the permission');
      //Main Message send here
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          Pushnotification notification = Pushnotification(
            title: message.notification?.title,
            body: message.notification?.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body'],
          );
          setState(() {
            _totalNotificaitonCounter++;
            _pushnotification = notification;
          });
          showSimpleNotification(
            Text(_pushnotification!.title!),
            subtitle: Text(_pushnotification!.body!),
            background: Colors.green.shade500,
            duration: const Duration(seconds: 3),
          );
        },
      );
    } else {
      print('permission decline by user.!');
    }
  }

  @override
  void initState() {
    registerNotfication();
    _totalNotificaitonCounter = 0;
    super.initState();
  }
//***************FIREBASE CLOUD MESSAGING********************* */

  @override
  void didChangeDependencies() async {
    if (init) {
      Provider.of<AdvertiseState>(context, listen: false).getAdvertise();
      Provider.of<VehicleState>(context, listen: false).getBrandDetails();

      // Provider.of<SearchState>(context).searchVehicle(searchVehicle!);
      Provider.of<CartState>(context, listen: false).getCartData();

      Provider.of<RentState>(context, listen: false).getRentalHistory();
      isLoading = await Provider.of<VehicleState>(context, listen: false)
          .getMostSearchVehicle();
      isLoading = await Provider.of<VehicleState>(context, listen: false)
          .getPopularVehicles();
      isLoading =
          await Provider.of<VehicleState>(context, listen: false).getVehicles();

      setState(() {});
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cart;
    Size size = MediaQuery.of(context).size;
    if (!isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          elevation: 10,
        ),
        drawer: const Drawer(
          child: DrawerApp(),
        ),
        body: const Center(
          child: SpinKitPulse(
            color: Colors.blue,
          ),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: AppColor.WHITE,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Colors.blue.shade800,
              // iconTheme: const IconThemeData(color: Colors.black),
              elevation: 10,
              actions: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  // width: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: Stack(
                      children: [
                        const IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: null,
                        ),
                        Positioned(
                          top: 1,
                          left: 30,
                          right: 2,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cart != null
                                  ? "${cart.cartvehicles!.length}"
                                  : '0',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          drawer: const Drawer(
            //backgroundColor: Colors.blue.shade100,
            child: DrawerApp(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userD(),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const VehicleSlider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),
                  Text(
                    'Available Vehicle',
                    style: GoogleFonts.oswald(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: availableVehicle(),
                    height: 250,
                  ),

                  // gridView(),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Popular Vehicle',
                    style: GoogleFonts.oswald(
                      fontSize: 30,
                    ),
                  ),
                  //
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  //
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(23),
                    ),
                    height: 250,
                    child: listView(),
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),
                  Center(child: learnMore()),
                  /////////////////////////////////////////////////////////////////////
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 2,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Text(
                    'Most Searched Vehicle',
                    style: GoogleFonts.oswald(
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: mostSearchVehicle(),
                    height: 250,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                ],
              ),
            ),
          ));
    }
  }

  //User detail fetch in homepage*****************
  Widget userD() {
    ProfileResponse = Provider.of<PostState>(context).userDetail();
    return FutureBuilder<Profile?>(
        future: ProfileResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Welcome..!\n',
                          style: GoogleFonts.oswald(
                            color: AppColor.BLACK,
                            fontSize: 35,
                          )),
                      TextSpan(
                          text: '${snapshot.data!.user!.username}',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 24,
                            // letterSpacing: 1,
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )
                    //Text('Welcome back..! ${snapshot.data!.user!.username}'),
                    ),
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.blue[900],
                  child: CachedNetworkImage(
                    imageUrl:
                        "http://192.168.1.66:8000${snapshot.data!.profileImage}",
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
                      //child: Icon(Icons.error),
                      backgroundImage: AssetImage('images/no_profile.jpg'),
                    ),
                    imageBuilder: (con, imageprov) => CircleAvatar(
                      radius: 60,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageprov,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SpinKitChasingDots(
            color: Colors.blue.shade400,
          );
        });
  }

  Widget listView() {
    Size size = MediaQuery.of(context).size;
    final vehicle = Provider.of<VehicleState>(context).popularVehicles;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: vehicle.length,
      itemBuilder: (ctx, i) => ListViewVehicle(
        id: vehicle[i].id,
        brand: vehicle[i].vehicles!.Brand!.title,
        image: vehicle[i].vehicles!.image,
        title: vehicle[i].vehicles!.title,
        price: vehicle[i].vehicles!.rentalPrice,
        fav: vehicle[i].favourite,
      ),
    );
  }

  //available vehicles
  Widget availableVehicle() {
    final vehicle = Provider.of<VehicleState>(context).vehicles;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: vehicle.length,
      itemBuilder: (ctx, i) => SingleVehicle(
        brand: vehicle[i].Brand!.title,
        id: vehicle[i].id,
        title: vehicle[i].title,
        price: vehicle[i].rentalPrice,
        image: vehicle[i].image,
        fav: vehicle[i].favourite,
      ),
    );
  }

//Vehicles in GridView Form
  Widget gridView() {
    Size size = MediaQuery.of(context).size;
    final vehicle = Provider.of<VehicleState>(context).vehicles;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.23 / 3,
        crossAxisSpacing: 7,
        mainAxisSpacing: 15,
      ),
      itemCount: vehicle.length,
      itemBuilder: (ctx, i) => SingleVehicle(
        brand: vehicle[i].Brand!.title,
        id: vehicle[i].id,
        title: vehicle[i].title,
        price: vehicle[i].rentalPrice,
        image: vehicle[i].image,
        fav: vehicle[i].favourite,
      ),
    );
  }

//For most search vehicle

  Widget mostSearchVehicle() {
    final mostSearchVehicle =
        Provider.of<VehicleState>(context).mostSearchVehicles;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mostSearchVehicle.length,
        itemBuilder: (ctx, i) => SingleMostSearchVehicle(
              id: mostSearchVehicle[i].id,
              brand: mostSearchVehicle[i].vehicles!.Brand!.title,
              image: mostSearchVehicle[i].vehicles!.image,
              price: mostSearchVehicle[i].vehicles!.rentalPrice,
              title: mostSearchVehicle[i].vehicles!.title,
              fav: mostSearchVehicle[i].favourite,
            ));
  }

  Widget learnMore() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/nepal_mountain_vehicle.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 80, 108, 170).withOpacity(.7),
              BlendMode.hardLight),
        ),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'AutoRent Nepal',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Want to know more about us..!',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AboutUsScreen.routeName);
            },
            child: const Text('Learn More'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[400],
              elevation: 10,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
