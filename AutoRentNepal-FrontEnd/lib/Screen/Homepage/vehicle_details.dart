import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/rent_vehicle_screen.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VehicleDetails extends StatefulWidget {
  final int? id;
  static const routeName = '/vehicle--screens';
  const VehicleDetails({Key? key, this.id}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  var selectedColor = Colors.blue;
  var isFavourite = false;
  var isbookmarked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments;
    final vehicle = Provider.of<VehicleState>(context).singleVehicle(id as int);
    final cart = Provider.of<CartState>(context).cart;
    final fav = vehicle!.favourite;
    return Scaffold(
      backgroundColor: AppColor.WHITE,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Column(
            children: [
              const Text("Brand",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("${vehicle.Brand!.title}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.WHITE,
              )),
          elevation: 10,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                //************ */
                Column(
                  children: [
                    Image.network("${vehicle.image}"),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${vehicle.title}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 24),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                height: 2.0,
                                width: size.width * 0.1,
                                color: const Color(0xff00c6ff)),
                            Text(
                              " \u{20B9}${vehicle.rentalPrice}/Day",
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                //fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                //*********************** */
                const Text("Description",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: size.width * 0.1,
                    color: const Color(0xff00c6ff)),
                // ***************
                Column(
                  children: [
                    Text(
                      "${vehicle.descrition}",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                const Text("Specification",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                //******************** */
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: size.width * 0.1,
                    color: const Color(0xff00c6ff)),
                //********** */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Seater',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontSize: 14,
                          )),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Image.asset(
                          'images/seat.png',
                          height: 25,
                          width: 35,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          "${vehicle.seater}",
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                        ),
                      ],
                    ),
                    //
                    // SizedBox(
                    //   width: size.width * 0.1,
                    // ),
                    //
                    Column(
                      children: [
                        Text(
                          'Engine',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontSize: 14,
                          )),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Image.asset(
                          'images/car-engine.png',
                          height: 25,
                          width: 35,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          "${vehicle.engine}",
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                        ),
                      ],
                    ),
                    //
                    // SizedBox(
                    //   width: size.width * 0.1,
                    // ),
                    //
                    Column(
                      children: [
                        Text(
                          'Type',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontSize: 14,
                          )),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Image.asset(
                          'images/car-type.png',
                          height: 25,
                          width: 35,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          "${vehicle.carType}",
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RentVehicleScreen.routeName,
                          arguments: id,
                        );
                      },
                      child: const Text(
                        'Rent',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade800,
                        elevation: 10,
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.width * 0.21),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    //******************* */

                    ElevatedButton(
                      onPressed: () {
                        Provider.of<CartState>(context, listen: false)
                            .addtoCart(id);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          title: 'Vehicle Added..!',
                          desc: '${vehicle.title} is added to cart',
                          btnOkOnPress: () {},
                        ).show();
                      },
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            bottom: size.height * 0.02),
                        primary: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                      ),
                    ),

                    FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      backgroundColor: Colors.blue.shade700,
                      onPressed: () {
                        Provider.of<VehicleState>(context, listen: false)
                            .favouriteButton(id);
                      },
                      child: Icon(
                        fav! ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _getGradient() {
    return Container(
      margin: const EdgeInsets.only(top: 130.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            const Color(0x00736AB7),
            Colors.grey.shade300,
          ],
          stops: const [0.0, 0.8],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }
}
