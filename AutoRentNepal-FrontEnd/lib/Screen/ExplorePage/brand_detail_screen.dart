import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/single_explore_vehicle.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrandDetailScreen extends StatefulWidget {
  static const routeName = 'brand-details-screen';
  const BrandDetailScreen({Key? key}) : super(key: key);

  @override
  _BrandDetailScreenState createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments;
    print(id);
    final brandVehicleDetails =
        Provider.of<VehicleState>(context).brandVehicle(id as int);
    // final Brand = Provider.of<VehicleState>(context).brand;

    if (brandVehicleDetails.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Explore",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Vehicle",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sorry..!",
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                const SpinKitChasingDots(
                  color: Colors.blue,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Center(
                  child: Text(
                    "The vehicles for this brand\n is currently unavailable..!",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: [
                const Text("Explore",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text(" ${brandVehicleDetails[0].Brand!.title}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
          ),
        ),
        // ${brandVehicleDetails[0].Brand!.title}
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            //padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.8 / 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 9,
            ),
            itemCount: brandVehicleDetails.length,
            itemBuilder: (ctx, i) => SingleExploreVehicle(
              brand: brandVehicleDetails[i].Brand!.title,
              price: brandVehicleDetails[i].rentalPrice,
              id: brandVehicleDetails[i].id,
              image: brandVehicleDetails[i].image,
              title: brandVehicleDetails[i].title,
            ),

            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: brandVehicleDetails.length,
            //   itemBuilder: (ctx, i) =>
            // SingleVehicle(
            //     id: brandVehicleDetails[i].id,
            //     image: brandVehicleDetails[i].image,
            //     title: brandVehicleDetails[i].title,
            //   ),
            // ),
          ),
        ),
      );
    }
    // return brandVehicleDetails.length == 0
    //     ? Scaffold(
    //         appBar: AppBar(
    //           title: Text("No post for This Category"),
    //         ),
    //         body: Center(
    //           child: Text("No Post"),
    //         ),
    //       )
    //     : Scaffold(
    //         appBar: PreferredSize(
    //           preferredSize: const Size.fromHeight(60),
    //           child: AppBar(
    //             title: Text(
    //                 "All Post for ${brandVehicleDetails[0].Brand!.title} ",
    //                 style: GoogleFonts.roboto(fontSize: 20)),
    //             centerTitle: true,
    //           ),
    //         ),
    //         body: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: GridView.builder(
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             //padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               childAspectRatio: 2.6 / 3,
    //               crossAxisSpacing: 9,
    //               mainAxisSpacing: 9,
    //             ),
    //             itemCount: brandVehicleDetails.length,
    //             itemBuilder: (ctx, i) => SingleVehicle(
    //               brand: brandVehicleDetails[i].Brand!.title,
    //               price: brandVehicleDetails[i].rentalPrice,
    //               id: brandVehicleDetails[i].id,
    //               image: brandVehicleDetails[i].image,
    //               title: brandVehicleDetails[i].title,
    //             ),

    //             // ListView.builder(
    //             //   shrinkWrap: true,
    //             //   itemCount: brandVehicleDetails.length,
    //             //   itemBuilder: (ctx, i) =>
    //             // SingleVehicle(
    //             //     id: brandVehicleDetails[i].id,
    //             //     image: brandVehicleDetails[i].image,
    //             //     title: brandVehicleDetails[i].title,
    //             //   ),
    //             // ),
    //           ),
    //         ),
    //       );

    // Scaffold(
    //   appBar: AppBar(title: Text("Brand Vehicles")),
    //   body: SingleChildScrollView(
    //       child: Column(
    //     children: [
    //       gridView(),
    //     ],
    //   )),
    // );
  }

//   Widget gridView() {
//     Size size = MediaQuery.of(context).size;
//     //final Brand = Provider.of<VehicleState>(context).brand;
//     //final vehicle = Provider.of<VehicleState>(context).vehicles;
//     final Brandvehicles = Provider.of<VehicleState>(context).brandVehiclesss;
//     return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         //padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 4 / 3,
//           crossAxisSpacing: 9,
//           mainAxisSpacing: 9,
//         ),
//         itemCount: Brandvehicles!.length,
//         itemBuilder: (ctx, i) {
//           return Container(
//               //child: Brandvehicles[i].vehicles,
//               );
//         });
//   }
// }

// class BrandDetailsScreen extends StatelessWidget {
//   static const routeName = '/Brand-detail-screens';
//   const BrandDetailsScreen({Key? key}) : super(key: key);

// //  bool init = true;
// //   bool isLoading = false;

//   //  @override
//   // void didChangeDependencies() async {
//   //   if (init) {
//   //     // ProfileResponse = Provider.of<PostState>(context).userDetail();
//   //     // isLoading = await Provider.of<VehicleState>(context, listen: false)
//   //     //     .getPopularVehicles();
//   //      Provider.of<VehicleState>(context, listen: false).getBrandVehicles();
//   //     Provider.of<VehicleState>(context, listen: false).getBrandDetails();
//   //     isLoading =
//   //         await Provider.of<VehicleState>(context, listen: false).getVehicles();

//   //     setState(() {});
//   //   }
//   //   init = false;
//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {

//   }
// }
}
