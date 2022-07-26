import 'package:auto_rent_nepal_fyp/Screen/Splash/splash_screen.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/advertise_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/feedback_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/rent_provider.dart';
// import 'package:auto_rent_nepal_fyp/api/Provider/driver_provider.dart';
// import 'package:auto_rent_nepal_fyp/api/Provider/popularVehicle_state.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/search_state.dart';
//import 'package:auto_rent_nepal_fyp/api/Provider/theme_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/api/driver_api.dart';
import 'package:auto_rent_nepal_fyp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

FlutterSecureStorage? secureStorage;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51KkQPTBRZ15pc91RILrqiMPxYhby0X9FDAgLQQm7sf4V9H21hi0JhGu5UpwlMTPEFyVi0oRnq61RlKjLngCAQqIl00DvpoIkvA';
  secureStorage = const FlutterSecureStorage();
  runApp(MultiProvider(providers: [
    //ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
    ChangeNotifierProvider(create: (ctx) => PostState()),
    ChangeNotifierProvider(create: (ctx) => VehicleState()),
    ChangeNotifierProvider(create: (ctx) => SearchState()),
    ChangeNotifierProvider(create: (ctx) => CartState()),
    ChangeNotifierProvider(create: (ctx) => AdvertiseState()),
    ChangeNotifierProvider(create: (ctx) => FeedbackState()),
    ChangeNotifierProvider(create: (ctx) => DriverState()),
    ChangeNotifierProvider(create: (ctx) => RentState()),
  ], child: const AutoRentNepal()));
}

class AutoRentNepal extends StatelessWidget {
  const AutoRentNepal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // themeMode: themeProvider.themeMode,
        // theme: MyThemes.lightTheme,
        // darkTheme: MyThemes.darkTheme,
        home: SplashScreen(),
        //     FutureBuilder(
        //   builder: (context, snapshot) {
        //     // ignore: avoid_print
        //     print('Token Key is saved : ${snapshot.data}');
        //     // if (snapshot.data == null) {
        //     //   return const Scaffold(
        //     //     body: Center(
        //     //       child: CircularProgressIndicator(
        //     //         color: Colors.red,
        //     //       ),
        //     //     ),
        //     //   );
        //     // }
        //     if (snapshot.data != null) {
        //       return const LandingPage();
        //     }
        //     return SplashScreen();

        //     // if (Snapshot.data == null) {
        //     //   return const Scaffold(
        //     //     body: Center(
        //     //       child: CircularProgressIndicator(),
        //     //     ),
        //     //   );
        //     // }
        //     // if (storage.getItem('key') == null) {
        //     //   return const WelcomeScreen(); // Here you should keep the splash page so that login and signup option page.
        //     // }
        //     // return const LandingPage();
        //   },
        //   future: checkToken(),
        // ),

        routes: routes,
      ),
    );
  }
}
