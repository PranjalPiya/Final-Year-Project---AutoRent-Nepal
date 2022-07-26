import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/Screen/Login/ForgetPassword/forgot_password_screen.dart';
import 'package:auto_rent_nepal_fyp/Screen/Registration/signup_screen.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/loading.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _emailText = "";
  String _passwordText = "";
  bool _obscureText = true;
  bool isloading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _loginKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            //**********************Email*********** */
            TextFormField(
              controller: _emailController,
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                _emailText = value;
              },
              keyboardType: TextInputType.emailAddress,
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
            //********************Password ***************/
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
            //****************************** */
            SizedBox(height: size.height * 0.01),
            //*****Forgot Password**** */
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                    text: 'Forgot Password',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,

                        //fontWeight: FontWeight.w100,
                        color: AppColor.BLACK,
                      ),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .pushNamed(ForgotPasswordScreen.routeName);
                        print('forgot password is working properly');

                        //if user forgot their password.
                      }),
              ),
            ),
            //************ */

            SizedBox(height: size.height * 0.05),
            //*********************LoginButton************ */
            _loginButton(),

            //******** */
            SizedBox(height: size.height * 0.02),
            //******* */

            SizedBox(height: size.height * 0.01),
            //************************************* */
            RichText(
              text: TextSpan(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: AppColor.BLACK,
                    fontSize: 15,
                  ),
                ),
                children: [
                  //*************** */
                  const TextSpan(text: 'Don\'t have an account? '),
                  //*********** */
                  TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // goes to sign up page.
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    Size size = MediaQuery.of(context).size;
    return isloading
        ? Center(
            child: AlertDialog(
            content: LoadingIndicator.FoldingCubeIndicator('Loading...'),
          )
            // LoadingIndicator.FoldingCubeIndicator('Loading...'),
            )
        : ElevatedButton(
            onPressed: () async {
              if (_loginKey.currentState!.validate()) {
                _loginKey.currentState!.save();
                isloading = true;
                setState(() {});
                await Future.delayed(const Duration(seconds: 1));
                bool islogin =
                    await Provider.of<PostState>(context, listen: false)
                        .login(_emailController.text, _passwordController.text);

                if (islogin) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LandingPage()));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("ERROR..!",
                            textAlign: TextAlign.justify),
                        elevation: 10,
                        content: const Text(
                            'The email/password does not seems valid. Please try again'),
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
            },
            child: Text(
              "Login",
              style: GoogleFonts.roboto(
                  fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
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
