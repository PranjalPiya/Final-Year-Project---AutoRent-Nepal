import 'package:auto_rent_nepal_fyp/api/Provider/rent_provider.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentalHistory extends StatelessWidget {
  static const routeName = 'rental-history';
  const RentalHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RentalHistoryBody();
  }
}

class RentalHistoryBody extends StatefulWidget {
  const RentalHistoryBody({
    Key? key,
  }) : super(key: key);

  @override
  State<RentalHistoryBody> createState() => _RentalHistoryBodyState();
}

class _RentalHistoryBodyState extends State<RentalHistoryBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<RentState>(context).rents;
    if (data!.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Rental",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("History",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
            actions: const [
              Icon(Icons.history),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No History",
                style: GoogleFonts.roboto(
                  fontSize: 25,
                ),
              ),
              Image.asset(
                'images/empty_cart.png',
                height: 250,
                width: 500,
              ),
              // Text(
              //   "R..!",
              //   style: GoogleFonts.roboto(
              //     fontSize: 20,
              //   ),
              // )
            ],
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
              children: const [
                Text("Rental",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("History",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
            actions: const [
              Icon(Icons.history),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        // drawer: AppDrower(),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                data;
              });
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                print(data.length);
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: "${data[i].vehicle!.image}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                child: SpinKitCircle(
                                  color: AppColor.RED,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (con, imageprov) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: imageprov,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${data[i].vehicle!.title}",
                                  style: GoogleFonts.oswald(
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  "Address: ${data[i].address}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  "Start Date: ${data[i].startDate}",
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold)
                                      ),
                                ),
                                Text(
                                  "End Date: ${data[i].endDate}",
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold)
                                      ),
                                ),
                                // Text('${data[i].id}'),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          title: Text(
                                            "Information".toUpperCase(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                              'Do you really want to cancel the ride..?'),
                                          actions: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.green.shade600,
                                              onPressed: () {
                                                Provider.of<RentState>(context,
                                                        listen: false)
                                                    .deleteRentVehicle(
                                                        data[i].id!);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Yes",
                                              ),
                                            ),
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.red.shade600,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('No'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    print('Pressed');
                                  },
                                  child: const Text('Cancel Rent'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red[800],
                                    elevation: 10,
                                    // padding: EdgeInsets.symmetric(
                                    //   vertical: size.height * 0.01,
                                    //   horizontal: size.width * 0.3,
                                    // ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                )
                                // paid ? const Text('Paid') : const Text('Unpaid'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
