// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/check_out.dart';
import 'package:auto_rent_nepal_fyp/Screen/RentVehicle/check_out_without_liscense.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/models/profile.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RentVehicleBody extends StatefulWidget {
  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  const RentVehicleBody({Key? key}) : super(key: key);

  @override
  State<RentVehicleBody> createState() => _RentVehicleBodyState();
}

class _RentVehicleBodyState extends State<RentVehicleBody> {
  Map<String, dynamic>? paymentIntentData;
  final _rentKey = GlobalKey<FormState>();
  // final int? id;
  bool onlinePayment = false;
  bool wantDriver = false;
  bool cashOnDelivery = false;
  final _addressController = TextEditingController();

  //***********************DATE SELECTION************8 */
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 24));

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange); // pressed save
  }

  //************************ */
  String? hehe;
  final _startDate = TextEditingController(text: '');
  final _endDate = TextEditingController();
  final _rentDays = TextEditingController(text: '');
  final _rentPrice = TextEditingController();
  final _newValue = '';
  String? rentDays = '';
  String? rentPrice = "";
  String? startDate = '';
  String? endDate = '';
  // final TextEditingController _rentDays = TextEditingController();
  int? _multiply;
  int? totalRentDay;

  @override
  void initState() {
    _multiply = 0;
  }
  //*********************DATE SELECTION************* */

  //*********************IMAGE PICKER************** */
  File? selectedImage;
  final imagepicker = ImagePicker();
  Future getImage(ImageSource source) async {
    var choosedimage = await imagepicker.getImage(
        source: source,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (choosedimage != null) {
      selectedImage = File(choosedimage.path);
      setState(() {});
    } else {
      print('no image selected');
    }
    return;
    //set source: ImageSource.camera to get image from camera
  }

  //*************IMAGE PICKER******************** */

  //*******************GOOGLE MAP**************** */
  PickResult? selectedPlace;
  bool showGoogleMapInContainer = false;
  final String apiKey = 'AIzaSyBtFWPrKSkTTbZLUbifgq0NmM37Chcu-Dk';

  //**************GOOGLE MAP************************* */

  var ProfileResponse;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments;
    final vehicle = Provider.of<VehicleState>(context).singleVehicle(id as int);
    final cart = Provider.of<CartState>(context).cart;
    ProfileResponse = Provider.of<PostState>(context).userDetail();
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue.shade800,
          centerTitle: true,
          title: Column(
            children: const [
              Text("Vehicle",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("Rent",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _rentKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlacePicker(
                                      apiKey:
                                          Platform.isAndroid ? apiKey : apiKey,
                                      hintText: "Find a place ...",
                                      searchingText: "Please wait ...",
                                      selectText: "Select place",
                                      outsideOfPickAreaText:
                                          "Place not in area",
                                      initialPosition:
                                          RentVehicleBody.kInitialPosition,
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,
                                      usePinPointingSearch: true,
                                      usePlaceDetailSearch: true,
                                      onPlacePicked: (PickResult result) {
                                        setState(() {
                                          selectedPlace = result;
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('Set Location'),
                          ),
                        ],
                      ),
                      selectedPlace == null
                          ? TextFormField(
                              controller: _addressController,
                              onTap: () => FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                // _usernameText = value;
                              },
                              validator: (value) {
                                return TextFieldValidator.addressValidation(
                                    value);
                              },
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColor.BLACK,
                                ),
                                hintText: "place your address",
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.BLACK),
                                ),
                              ),
                            )
                          : TextFormField(
                              controller: TextEditingController()
                                ..text = selectedPlace!.formattedAddress ?? "",

                              onTap: () => FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                // _usernameText = value;
                              },
                              validator: (value) {
                                return TextFieldValidator.addressValidation(
                                    value);
                              },
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColor.BLACK,
                                ),
                                hintText: "place your heheheh address",
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.BLACK),
                                ),
                              ),
                              //  selectedPlace!.formattedAddress ?? ""
                            ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'Select the date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //DateTextform Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //**************START DATE***********8 */
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text:
                                      '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}'),
                              onChanged: (value) {
                                startDate = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 23),
                                hintText:
                                    '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: pickDateRange,
                            ),
                          ),
                          //
                          const SizedBox(
                            width: 50,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                          //**********************END DATE************** */
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text:
                                      '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}'),
                              onChanged: (value) {
                                endDate = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 23),
                                hintText:
                                    '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: pickDateRange,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //Payment Method
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //Online and OffLine pay
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: const Text('Online Payment'),
                              leading: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                value: onlinePayment,
                                onChanged: (value) {
                                  setState(() {
                                    onlinePayment = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: const Text('Cash On Delivery'),
                              leading: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                value: cashOnDelivery,
                                onChanged: (value) {
                                  setState(() {
                                    cashOnDelivery = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                        ],
                      ),
                      //For Driving Liscense
                      Visibility(
                        visible: !wantDriver,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add your driving liscense',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.grey,
                              )),
                              height: 150,
                              width: 200,
                              child: selectedImage == null
                                  ? IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) => bottomSheet()),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 100,
                                        color: Colors.blue.shade400,
                                      ))
                                  : Stack(
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: 200,
                                          child: Image.file(
                                            selectedImage!,
                                          ),
                                        ),
                                        Positioned(
                                          right: 40.0,
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                selectedImage = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //************** IF YOU WANT DRIVER *****************888 */
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: wantDriver,
                              onChanged: (value) {
                                setState(() {
                                  wantDriver = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'Do you want a driver..?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //******************BUTTON FOR CONTINUE************** */
                      FutureBuilder<Profile?>(
                          future: ProfileResponse,
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              print(snapshot.data!.user!.fullName);
                              return ElevatedButton(
                                onPressed: onlinePayment
                                    ? () async {
                                        if (_rentKey.currentState!.validate()) {
                                          _rentKey.currentState!.save();
                                          setState(() {
                                            _multiply = int.parse(
                                                    '${dateRange.duration.inDays}') *
                                                int.parse(
                                                    "${vehicle!.rentalPrice}");
                                          });
                                          await makePayment(
                                            amount: '$_multiply',
                                            currency: 'INR',
                                            email:
                                                ' Payment Made by ${snapshot.data!.user!.email}',
                                          );
                                        }
                                      }
                                    : cashOnDelivery
                                        ? () async {
                                            if (_rentKey.currentState!
                                                .validate()) {
                                              _rentKey.currentState!.save();
                                              if (selectedImage != null &&
                                                  wantDriver == false) {
                                                setState(() {
                                                  _multiply = int.parse(
                                                          '${dateRange.duration.inDays}') *
                                                      int.parse(
                                                          "${vehicle!.rentalPrice}");
                                                });
                                                setState(() {
                                                  totalRentDay =
                                                      dateRange.duration.inDays;
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckOutBody(
                                                      paid: false,
                                                      address: selectedPlace !=
                                                              null
                                                          ? selectedPlace!
                                                                  .formattedAddress ??
                                                              ""
                                                          : _addressController
                                                              .text,
                                                      startDate:
                                                          '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}',
                                                      endDate:
                                                          '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}',
                                                      brand:
                                                          vehicle!.Brand!.title,
                                                      title: vehicle.title,
                                                      totalPrice: _multiply,
                                                      rentalPrice:
                                                          vehicle.rentalPrice,
                                                      images: vehicle.image,
                                                      totalRentalDays:
                                                          totalRentDay,
                                                      vehicleID: vehicle.id,
                                                      liscenseImage:
                                                          selectedImage,
                                                    ),
                                                  ),
                                                );
                                              } else if (selectedImage ==
                                                      null &&
                                                  wantDriver == true) {
                                                setState(() {
                                                  _multiply = int.parse(
                                                          '${dateRange.duration.inDays}') *
                                                      int.parse(
                                                          "${vehicle!.rentalPrice}");
                                                });
                                                setState(() {
                                                  totalRentDay =
                                                      dateRange.duration.inDays;
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckOutWithOutLiscense(
                                                      vehicleId: vehicle!.id,
                                                      paid: false,
                                                      address: selectedPlace !=
                                                              null
                                                          ? selectedPlace!
                                                                  .formattedAddress ??
                                                              ""
                                                          : _addressController
                                                              .text,
                                                      startDate:
                                                          '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}',
                                                      endDate:
                                                          '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}',
                                                      brand:
                                                          vehicle.Brand!.title,
                                                      title: vehicle.title,
                                                      totalPrice: _multiply,
                                                      rentalPrice:
                                                          vehicle.rentalPrice,
                                                      images: vehicle.image,
                                                      totalRentalDays:
                                                          totalRentDay,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                        "WARNING....! ",
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      elevation: 10,
                                                      content: const Text(
                                                          'Please Provide your Driving Liscense'),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      actions: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            // isloading = false;
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("Ok"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                print('No image');
                                              }
                                            }
                                          }
                                        : null,
                                child: Text(
                                  'Continue',
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
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
                              );
                            }
                            return SpinKitChasingDots(
                              color: Colors.blue.shade400,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future makePayment(
      {required String amount,
      required String currency,
      required email}) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, currency, email); //json.decode(response.body);
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.light,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE',
              customerId: paymentIntentData!['customer'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ))
            .then((value) {});

        ///now finally display payment sheeet
        /// It first check where user has provided the the liscense or not.
        if (selectedImage == null && wantDriver == false) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "WARNING....! ",
                  textAlign: TextAlign.justify,
                ),
                elevation: 10,
                content: const Text('Please Provide your Driving Liscense'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      // isloading = false;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              );
            },
          );
        } else {
          displayPaymentSheet();
        }
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    final id = ModalRoute.of(context)?.settings.arguments;
    final vehicle = Provider.of<VehicleState>(context, listen: false)
        .singleVehicle(id as int);
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        _multiply = int.parse('${dateRange.duration.inDays}') *
            int.parse("${vehicle!.rentalPrice}");
      });
      setState(() {
        totalRentDay = dateRange.duration.inDays;
      });
      if (selectedImage != null && wantDriver == false) {
        setState(() {
          _multiply = int.parse('${dateRange.duration.inDays}') *
              int.parse("${vehicle!.rentalPrice}");
        });
        setState(() {
          totalRentDay = dateRange.duration.inDays;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckOutBody(
              vehicleID: vehicle!.id,
              paid: true,
              brand: vehicle.Brand!.title,
              title: vehicle.title,
              rentalPrice: vehicle.rentalPrice,
              totalPrice: _multiply,
              totalRentalDays: totalRentDay,
              address: selectedPlace != null
                  ? selectedPlace!.formattedAddress ?? ""
                  : _addressController.text,
              images: vehicle.image,
              liscenseImage: selectedImage,
              startDate:
                  '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}',
              endDate:
                  '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}',
            ),
          ),
        );
      } else if (selectedImage == null && wantDriver == true) {
        setState(() {
          _multiply = int.parse('${dateRange.duration.inDays}') *
              int.parse("${vehicle!.rentalPrice}");
        });
        setState(() {
          totalRentDay = dateRange.duration.inDays;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckOutWithOutLiscense(
              // nullLiscense: null,
              vehicleId: vehicle!.id,
              paid: true,
              address: selectedPlace != null
                  ? selectedPlace!.formattedAddress ?? ""
                  : _addressController.text,
              startDate:
                  '${dateRange.start.year}-${dateRange.start.month}-${dateRange.start.day}',
              endDate:
                  '${dateRange.end.year}-${dateRange.end.month}-${dateRange.end.day}',
              brand: vehicle.Brand!.title,
              title: vehicle.title,
              totalPrice: _multiply,
              rentalPrice: vehicle.rentalPrice,
              images: vehicle.image,
              totalRentalDays: totalRentDay,
            ),
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "paid successfully",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
      ));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency, String email) async {
    calculateAmount(String amount) {
      final a = (int.parse(amount)) * 100;
      return a.toString();
    }

    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': email,
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KkQPTBRZ15pc91RIV7mxDUvhEZoyGzTJ40gmVuWAAyZRhEQI2tQN8wIY0CM4ssTnQvQXQ7CBuqYviQawTg2VFSi00RF9mZrhZ',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (e) {
      print('exeception' + e.toString());
    }
  }

  Widget bottomSheet() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Choose documents from",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.camera,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  label: const Text(
                    "Camera",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  label: const Text(
                    "Gallery",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  _priceCalculation() {
    Size size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments;
    final vehicle = Provider.of<VehicleState>(context, listen: false)
        .singleVehicle(id as int);
    setState(() {
      _multiply = int.parse('${dateRange.duration.inDays}') *
          int.parse("${vehicle!.rentalPrice}");
    });
  }
}
