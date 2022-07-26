//import 'dart:html';

import 'dart:io';
import 'package:auto_rent_nepal_fyp/api/ulrs.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:auto_rent_nepal_fyp/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/models/profile.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/editprofile-screens';
  late String? type;
  Profile? profile;
  EditProfile([this.type]);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var ProfileResponse;
  final _editProfileKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  File? image;

  bool isloading = false;
  String _fullNameText = '';
  String _emailText = '';
  String _phoneText = '';
  var decodeRes;
  bool init = true;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

//***************API for image upload****************************** */
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

//************************** API FOR PROFILE IMAGE UPLOAD */
  Dio dio = Dio();

  void onUploadImage() async {
    final String? key = await secureStorage!.read(key: 'key');
    try {
      String fileName = selectedImage!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profile_image": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: fileName,
          // headers:_header ,
          contentType: MediaType("image", "png"),
        ),
        "type": "image/png"
      });
      Response response = await dio.post(
        "http://${URL.homeIpAddress}:8000/accounts/updateprofile/",
        data: formData,
        options: Options(headers: {
          "accept": "*/*",
          "Authorization": "Token $key",
          "Content-Type": "multipart/form-data"
        }),
      );
      if (response.data['message'] == 'Profile is updated') {
        // AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.SUCCES,
        //   title: 'Profile Changed Successfully',
        //   btnOkOnPress: () {},
        // ).show();
        print('profile changed successful');
      } else if (response.data['message'] == 'Profile is not updated') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          title: 'Error while updating profile',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }

      print(response);
    } catch (e) {
      print(e);
    }
  }
//******************************************************************* */

  @override
  Widget build(BuildContext context) {
    ProfileResponse = Provider.of<PostState>(context).userDetail();
    Size size = MediaQuery.of(context).size;
    if (ProfileResponse == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Edit",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Profile",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: const [
              SpinKitChasingDots(
                color: Colors.black,
              ),
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
                Text("Edit",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Profile",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                ProfileResponse;
              });
            });
          },
          child: FutureBuilder<Profile?>(
            future: ProfileResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    key: _editProfileKey,
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue.shade100,
                                            width: 5),
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://192.168.1.66:8000${snapshot.data!.profileImage}",
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
                                            const CircleAvatar(
                                          radius: 60,
                                          backgroundImage: AssetImage(
                                              'images/no_profile.jpg'),
                                        ),
                                        imageBuilder: (con, imageprov) =>
                                            CircleAvatar(
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
                                    Positioned(
                                      bottom: 5.0,
                                      right: 10.0,
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                bottomSheet()),
                                          );
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.black,
                                            size: 28.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            const Text(
                              'Full Name:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.user!.fullName}',
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text(
                              'Email Address:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.user!.email}',
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text(
                              'Phone Number:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.user!.phoneNumber}',
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        //****************** */
                        SizedBox(
                          height: size.height * 0.0,
                        ),
                        //***************Full Name************ */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Update your Profile",
                                style: GoogleFonts.oswald(
                                  fontSize: 30,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              "Full Name:",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.BLACK,
                                ),
                              ),
                            ),
                            //***************FULL NAME******************8888 */
                            TextFormField(
                              controller: _fullName,
                              // initialValue:
                              //     '${snapshot.data!.user!.fullName}',
                              onTap: () => FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                _fullNameText = value;
                              },
                              validator: (value) {
                                return TextFieldValidator.fullNameValidation(
                                    value);
                              },
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: AppColor.BLACK,
                                ),
                                hintText: "${snapshot.data!.user!.fullName}",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.BLACK),
                                ),
                              ),
                            ),
                            //******** */
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            //******Email*********************** */
                            Text(
                              "Email:",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.BLACK,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _email,
                              //initialValue: '${snapshot.data!.user!.email}',
                              onTap: () => FocusScope.of(context).unfocus(),
                              // initialValue: ,
                              onChanged: (value) {
                                _emailText = value;
                              },
                              onSaved: (data) {
                                snapshot.data!.user!.email = data;
                              },
                              validator: (value) {
                                return TextFieldValidator.emailValidation(
                                    value);
                              },
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: AppColor.BLACK,
                                ),
                                hintText: "${snapshot.data!.user!.email}",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: const OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.WHITE),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.WHITE),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: AppColor.BLACK),
                                ),
                              ),
                            ),
                            //************ */
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            //********Phone Number********* */
                            Text(
                              "Phone Number:",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.BLACK,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _phone,
                              // initialValue:
                              //     '${snapshot.data!.user!.phoneNumber}',
                              onTap: () => FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                _phoneText = value;
                              },
                              onSaved: (data) {
                                snapshot.data!.user!.phoneNumber = data;
                              },
                              validator: (value) {
                                return TextFieldValidator.phoneNumberValidation(
                                    value);
                              },
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_outlined,
                                  color: AppColor.BLACK,
                                ),
                                hintText: "${snapshot.data!.user!.phoneNumber}",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                            ),
                          ],
                        ),

                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_editProfileKey.currentState!.validate()) {
                              _editProfileKey.currentState!.save();
                              isloading = true;
                              setState(() {});
                              await Future.delayed(const Duration(seconds: 1));
                              bool isUpdate = await Provider.of<PostState>(
                                      context,
                                      listen: false)
                                  .UserUpdate(
                                      _email.text, _phone.text, _fullName.text);
                              if (isUpdate = true) {
                                Fluttertoast.showToast(
                                    msg: 'Updated Successfully.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.blue[100],
                                    timeInSecForIosWeb: 1);
                                Navigator.of(context).pop();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Error while Update. Please Try Again"),
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
                          child: Text('Update',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[800],
                            elevation: 10,
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 0.02,
                                horizontal: size.height * 0.16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
    }
  }

  Widget bottomSheet() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile photo",
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
            SizedBox(
              height: 60,
              width: 100,
              //show upload button after choosing image
              child: selectedImage == null
                  ? null
                  : Image.file(
                      selectedImage!,
                    ),
            ),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
              onPressed: () {
                onUploadImage();
                setState(() {
                  ProfileResponse;
                });
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  title: 'Profile Picture Updated Successfully',
                  btnOkOnPress: () {},
                ).show();
              },
              child: Text('Update',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  )),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[800],
                elevation: 10,
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 0.019,
                    horizontal: size.height * 0.16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
