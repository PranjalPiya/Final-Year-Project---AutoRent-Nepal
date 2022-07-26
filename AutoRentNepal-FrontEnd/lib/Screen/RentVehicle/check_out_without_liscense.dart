import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/rent_successfull.dart';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CheckOutWithOutLiscense extends StatefulWidget {
  final int? vehicleId;
  final bool? paid;
  final String? address;
  final String? startDate;
  final String? endDate;
  final String? title;
  final String? brand;
  final int? totalPrice;
  final int? rentalPrice;
  final String? images;
  final int? totalRentalDays;
  // final File? nullLiscense;
  const CheckOutWithOutLiscense({
    Key? key,
    this.address,
    this.startDate,
    this.endDate,
    this.title,
    this.brand,
    this.totalPrice,
    this.rentalPrice,
    this.images,
    this.totalRentalDays,
    this.paid,
    this.vehicleId,
    // this.nullLiscense,
  }) : super(key: key);

  @override
  State<CheckOutWithOutLiscense> createState() => _CheckOutWithOutLiscenseState(
        address!,
        startDate!,
        endDate!,
        title!,
        brand!,
        totalPrice!,
        rentalPrice!,
        images!,
        totalRentalDays!,
        paid!,
        vehicleId!,
        //nullLiscense!,
      );
}

class _CheckOutWithOutLiscenseState extends State<CheckOutWithOutLiscense> {
  var ProfileResponse;
  final int vehicleId;
  final String address;
  final String startDate;
  final String endDate;
  final String title;
  final String brand;
  final int totalPrice;
  final int rentalPrice;
  final String image;
  final int totalRentalDays;
  final bool paid;
  //final File? nullLiscense;

  Dio dio = Dio();

  void _rentNow() async {
    // final File? nullL;
    const String noLiscense = '';
    final String? key = await secureStorage!.read(key: 'key');
    try {
      // String fileName = nullLiscense!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "vehicleid": "$vehicleId",
        "address": address,
        "start_date": startDate,
        "end_date": endDate,
        "document_upload": noLiscense,
        //  await MultipartFile.fromFile(
        //   nullLiscense!.path,
        //   filename: fileName,
        //   // headers:_header ,
        //   contentType: MediaType("image", "png"),
        // ),
        "type": "image/png"
      });
      Response response = await dio.post(
        "http://${URL.homeIpAddress}:8000/dashboard/rentnow/",
        data: formData,
        options: Options(headers: {
          "accept": "*/*",
          "Authorization": "Token $key",
          "Content-Type": "multipart/form-data"
        }),
      );
      if (response.data['message'] == 'Vehicle Rented Successfully') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          title: 'Vehicle Rented Succesfully',
          btnOkOnPress: () {
            Navigator.of(context).pushNamed(RentSuccessfulScreen.routeName);
            // Provider.of<CartState>(context, listen: false)
            //     .deleteVehicleCart(vehicleId);
          },
        ).show();
      } else if (response.data['message'] == 'Error while renting vehicle') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          title: 'Vehicle is already rented',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }

      print(response.data['message']);
    } catch (e) {
      print(e);
    }
  }

  _CheckOutWithOutLiscenseState(
    this.address,
    this.startDate,
    this.endDate,
    this.title,
    this.brand,
    this.totalPrice,
    this.rentalPrice,
    this.image,
    this.totalRentalDays,
    this.paid,
    this.vehicleId,
  );

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    //final vehicle = Provider.of<VehicleState>(context).singleVehicle(id as int);
    var ProfileResponse;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue.shade800,
          centerTitle: true,
          title: Column(
            children: const [
              Text("Check",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("Out",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //color: Colors.blue.shade100,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                    child: Column(
                      children: [
                        Text(title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          brand,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        CachedNetworkImage(
                          height: 100,
                          width: 200,
                          imageUrl: image,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            child: SpinKitCircle(
                              color: AppColor.RED,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 4,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(
                  children: [
                    //************ADDRESS*********8 */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Address:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //*****************START DATE**************** */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Start Date:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          startDate,
                          style: const TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //*****************END DATE**************** */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'End Date:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          endDate,
                          style: const TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //*******************STATUS****************** */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        paid
                            ? const Text(
                                'Paid',
                                style: TextStyle(
                                  fontSize: 17,
                                  //fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                'unpaid',
                                style: TextStyle(
                                  fontSize: 17,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    //******************* */
                    //******************* */
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      //thickness: 2,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //*****************RENTAL Price**************** */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sub-Total:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\u{20B9}$rentalPrice',
                          style: const TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //*******************TOTAL RENTAL DAYS*************** */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Rental Days:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$totalRentalDays Days',
                          style: const TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    //*******************TOTAL PRICE************* */
                    // SizedBox(
                    //   height: size.height * 0.03,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\u{20B9}$totalPrice',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                ElevatedButton(
                  onPressed: () {
                    _rentNow();
                    //  print('$startDate');
                    // Navigator.of(context)
                    //     .pushNamed(RentSuccessfulScreen.routeName);
                  },
                  child: const Text(
                    'Rent',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    elevation: 10,
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
