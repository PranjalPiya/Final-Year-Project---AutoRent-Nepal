import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';

import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/loading.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _registerKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String _emailText = "";
  String _passwordText = "";
  String _fullNameText = "";
  final String _phoneNumberText = "";
  String _confirmPasswordText = "";
  String _usernameText = "";
  bool _obscureText = true;
  bool isloading = false;
  bool checked = false;
  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _registerKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            //***************Username */
            TextFormField(
              controller: _usernameController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _usernameText = value;
              },
              validator: (value) {
                return TextFieldValidator.usernamneValidation(value);
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
                label: Text(
                  "Username",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter the Username",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),
            //***************************************8 */
            SizedBox(height: size.height * 0.02),
            //************Email******* */
            TextFormField(
              controller: _emailController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _emailText = value;
              },
              validator: (value) {
                return TextFieldValidator.emailValidation(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColor.BLACK,
                ),
                label: Text(
                  "Email",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      //fontWeight: FontWeight.w500,
                      fontSize: 20,
                      //fontWeight: FontWeight.w100,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter your email",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),
            //*************** */
            SizedBox(height: size.height * 0.02),
            //**********************FullName*********** */
            TextFormField(
              controller: _fullNameController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _fullNameText = value;
              },
              validator: (value) {
                return TextFieldValidator.fullNameValidation(value);
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
                label: Text(
                  "Full Name",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter your Name",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),

            //*************** */
            SizedBox(height: size.height * 0.02),
            //***************Phone Number******** */
            TextFormField(
              controller: _phoneNumberController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _emailText = value;
              },
              keyboardType: TextInputType.number,
              validator: (value) {
                return TextFieldValidator.phoneNumberValidation(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: AppColor.BLACK,
                ),
                label: Text(
                  "Phone Number",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter your Phone",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),
            //*************** */
            SizedBox(height: size.height * 0.02),
            //*******************Password **************/
            TextFormField(
              controller: _passwordController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _passwordText = value;
              },
              validator: (value) {
                return TextFieldValidator.passwordValidation(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: _obscureText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //This is for password visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColor.BLACK,
                  ),
                  onPressed: () {
                    print('The eye visibility is on and working.');
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                prefixIcon: const Icon(
                  Icons.vpn_key_outlined,
                  color: AppColor.BLACK,
                ),
                label: Text(
                  "Password",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter the password",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),
            //************************************ */
            SizedBox(height: size.height * 0.02),
            //********************Confirm Password ***************/
            TextFormField(
              controller: _confirmPasswordController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _confirmPasswordText = value;
              },
              validator: (value) {
                if (_confirmPasswordController.text !=
                    _passwordController.text) {
                  return 'Password didn\'t matched. Please try again.';
                }
                return TextFieldValidator.passwordValidation(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: _obscureText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //This is for password visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColor.BLACK,
                  ),
                  onPressed: () {
                    print('The eye visibility is on and working.');
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                prefixIcon: const Icon(
                  Icons.vpn_key_outlined,
                  color: AppColor.BLACK,
                ),
                label: Text(
                  "Confirm Password",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.BLACK,
                    ),
                  ),
                ),
                hintText: "Enter the password",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                filled: true,
                fillColor: Colors.blue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.WHITE),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColor.BLACK),
                ),
              ),
            ),

            //************ */
            SizedBox(height: size.height * 0.0),
            //***********Checkbox************************* */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      checked = value ?? false;
                    });
                  },
                ),
                const Text(
                  'I have read and accept terms and conditions.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            //*********************RegisterButton************ */
            _registerButton(),

            //******** */
            SizedBox(height: size.height * 0.0),
            //******RichText* */
            RichText(
              text: TextSpan(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: AppColor.BLACK,
                    fontSize: 15,
                  ),
                ),
                children: [
                  const TextSpan(
                    text: 'Already have an account? ',
                  ),
                  TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                          // goes to sign up page.
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    Size size = MediaQuery.of(context).size;
    return isloading
        ? Center(
            child: AlertDialog(
            content: LoadingIndicator.FoldingCubeIndicator('Loading...'),
          )
            // LoadingIndicator.FoldingCubeIndicator('Loading...'),
            )
        : ElevatedButton(
            onPressed: checked
                ? () async {
                    if (_registerKey.currentState!.validate()) {
                      _registerKey.currentState!.save();
                      isloading = true;
                      setState(() {});
                      await Future.delayed(const Duration(seconds: 1));
                      bool isRegister =
                          await Provider.of<PostState>(context, listen: false)
                              .registration(
                                  _usernameController.text,
                                  _fullNameController.text,
                                  _emailController.text,
                                  _phoneNumberController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text);
                      if (isRegister) {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);

                        Fluttertoast.showToast(
                          msg: 'Registered Successfully.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.purple[900],
                          //timeInSecForIosWeb: 1
                        );
                      } else {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       title: const Text(
                        //           "Error while registration. Please Try Again"),
                        //       actions: [
                        //         RaisedButton(
                        //           onPressed: () {
                        //             isloading = false;
                        //             setState(() {});
                        //             Navigator.of(context).pop();
                        //           },
                        //           child: const Text("Ok"),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("ERROR..!",
                                  textAlign: TextAlign.justify),
                              elevation: 10,
                              content: const Text(
                                  'Something is wrong. Please try again..!'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
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
                  }
                : null,
            child: Text(
              "Register",
              style: GoogleFonts.roboto(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
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
}
