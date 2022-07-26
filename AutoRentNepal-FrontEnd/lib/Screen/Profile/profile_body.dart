import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Cart/cart_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/edit_profile.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/Favourite/favourite_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Profile/rental_history.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/feedback_provider.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/api/storage.dart';
import 'package:auto_rent_nepal_fyp/models/profile.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String? image;
  String? username;
  bool init = true;
  bool isLoading = false;
  var ProfileResponse;

  @override
  void didChangeDependencies() {
    ProfileResponse = Provider.of<PostState>(context).userDetail();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 10.0,
          centerTitle: true,
          title: Text('Profile', style: GoogleFonts.roboto(fontSize: 30)),
          backgroundColor: Colors.blue.shade800,
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              ProfileResponse;
            });
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              user(),
              const SizedBox(
                height: 10,
              ),
              listView(),
              SizedBox(
                height: size.height * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Edit Profile',
              style: GoogleFonts.ubuntu(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
              print('working');
            },
            leading: const Icon(
              Icons.edit,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        //*********************** */
        const SizedBox(
          height: 10,
        ),
        //****************** */
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Favourite',
              style: GoogleFonts.ubuntu(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(FavouriteScreen.routeName);
              print('working');
            },
            leading: const Icon(
              Icons.favorite,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        //******************* */
        const SizedBox(
          height: 10,
        ),
        //********************** */
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Cart',
              style: GoogleFonts.ubuntu(),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()));

              print('working');
            },
            leading: const Icon(
              Icons.shopping_cart,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Rental History',
              style: GoogleFonts.ubuntu(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RentalHistory.routeName);
              print('working');
            },
            leading: const Icon(
              Icons.history,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Feedback',
              style: GoogleFonts.ubuntu(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              _feedback();
              print('working');
            },
            leading: const Icon(
              Icons.feedback,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: ListTile(
            title: Text(
              'Logout',
              style: GoogleFonts.ubuntu(
                  //color: Colors.red,
                  ),
            ),
            onTap: () {
              _logoutnow();
              print('working');
            },
            leading: const Icon(
              Icons.logout,
              color: AppColor.BLACK,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget user() {
    ProfileResponse = Provider.of<PostState>(context).userDetail();
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<Profile?>(
        future: ProfileResponse,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.shade100, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://192.168.1.66:8000${snapshot.data!.profileImage}",
                            progressIndicatorBuilder:
                                (context, url, progress) => const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              child: SpinKitCircle(
                                color: AppColor.RED,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage('images/no_profile.jpg'),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  '${snapshot.data!.user!.fullName} ',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  child: Text(
                    '@${snapshot.data!.user!.username}',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
              ],
            );
          }

          return const CircularProgressIndicator();
        });
  }

  _logoutnow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("LOGOUT"),
          content: const Text('Do you really want to Logout..?'),
          actions: [
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                deleteLogin();
                Fluttertoast.showToast(
                    msg: 'Logged Out Successfully.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.purple[900],
                    timeInSecForIosWeb: 1);
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: const Text("Ok"),
            ),
            RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            )
          ],
        );
      },
    );
  }

  _feedback() {
    Size size = MediaQuery.of(context).size;
    bool isloading = false;
    final _feedbackKey = GlobalKey<FormState>();
    TextEditingController _feedbackController = TextEditingController();

    @override
    void dispose() {
      _feedbackController.dispose();
      super.dispose();
    }

    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Form(
            key: _feedbackKey,
            child: Column(
              children: [
                const Text(
                  'Feedback',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    return TextFieldValidator.feedbackValidation(value);
                  },
                  onTap: () => FocusScope.of(context).unfocus(),
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 35),
                    prefixIcon: const Icon(Icons.feedback),
                    hintText: 'Provide your feedback...!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )),
      ),
      btnOkOnPress: () async {
        if (_feedbackKey.currentState!.validate()) {
          _feedbackKey.currentState!.save();
          await Future.delayed(const Duration(seconds: 1));
          bool isFeedbacked =
              await Provider.of<FeedbackState>(context, listen: false)
                  .FeedbackSubmit(
            _feedbackController.text,
          );
          if (isFeedbacked = true) {
            Fluttertoast.showToast(
              msg: 'Feedback submitted..!.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.purple[900],
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                      "Error while sending feedback. Please Try Again"),
                  actions: [
                    RaisedButton(
                      onPressed: () {
                        isloading = false;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      btnOkText: 'Submit',
      btnOkColor: Colors.green,
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnCancelColor: Colors.red,
    ).show();
  }
}
