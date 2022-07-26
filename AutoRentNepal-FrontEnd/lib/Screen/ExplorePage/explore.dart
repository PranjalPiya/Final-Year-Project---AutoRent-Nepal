import 'package:auto_rent_nepal_fyp/Screen/ExplorePage/single_brand.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExploreVehicle extends StatefulWidget {
  final title;
  static const routeName = '/explore-screen';
  const ExploreVehicle({Key? key, this.title}) : super(key: key);

  @override
  _ExploreVehicleState createState() => _ExploreVehicleState();
}

class _ExploreVehicleState extends State<ExploreVehicle> {
  bool init = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    if (init) {
      Provider.of<VehicleState>(context, listen: false).getBrandDetails();
      isLoading =
          await Provider.of<VehicleState>(context, listen: false).getVehicles();

      setState(() {});
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!isLoading) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[800],
            elevation: 10,
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[800],
            centerTitle: true,
            title: Text('Explore', style: GoogleFonts.roboto(fontSize: 30)),
          ),
        ),
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Divider(
                  thickness: 5,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                gridView(),
              ],
            ),
          ),
        ),
      );
    }
  }

  //
  Widget gridView() {
    Size size = MediaQuery.of(context).size;
    final Brand = Provider.of<VehicleState>(context).brand;
    // final vehicle = Provider.of<VehicleState>(context).vehicles;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 9,
        mainAxisSpacing: 9,
      ),
      itemCount: Brand!.length,
      itemBuilder: (ctx, i) => SingleBrand(brands: Brand[i]),
    );
  }
}
