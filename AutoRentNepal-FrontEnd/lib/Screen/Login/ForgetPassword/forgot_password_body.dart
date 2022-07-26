import 'package:auto_rent_nepal_fyp/Screen/Login/login_screen.dart';
import 'package:auto_rent_nepal_fyp/api/api.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/loading.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _resetPasswordKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isloading = false;

  String? _usernameText;
  String? _passwordText;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text("Forgot",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("Password",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
        ),
      ),
      body: Form(
        key: _resetPasswordKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Hello There...!',
                        style: GoogleFonts.oswald(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                  ]),
                ),
                Text(
                  '\nLooks like you have forgot your password, please provide your registered username and enter your new password.',
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text('Username'),
                SizedBox(
                  height: size.height * 0.01,
                ),
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
                      Icons.person_outline_outlined,
                      color: AppColor.BLACK,
                    ),
                    hintText: "Enter your Username",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    filled: true,
                    fillColor: Colors.blue[100],
                    border: const OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.WHITE),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      //  borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.WHITE),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.BLACK),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text('New Password'),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  onTap: () => FocusScope.of(context).unfocus(),
                  onChanged: (value) {
                    _passwordText = value;
                  },
                  validator: (value) {
                    return TextFieldValidator.passwordValidation(value);
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
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
                      Icons.lock_outline,
                      color: AppColor.BLACK,
                    ),
                    hintText: "Enter new Password",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    filled: true,
                    fillColor: Colors.blue[100],
                    border: const OutlineInputBorder(
                      //  borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.WHITE),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      //  borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.WHITE),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: AppColor.BLACK),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(child: forgotPassword()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    Size size = MediaQuery.of(context).size;

    return isloading
        ? Center(
            child:
                LoadingIndicator.FoldingCubeIndicator('Resetting Password...'),
          )
        : ElevatedButton(
            onPressed: () async {
              if (_resetPasswordKey.currentState!.validate()) {
                _resetPasswordKey.currentState!.save();
                isloading = true;
                setState(() {});
                await Future.delayed(const Duration(seconds: 1));
                bool isResetPassword =
                    await Provider.of<PostState>(context, listen: false)
                        .forgotPassword(
                            _usernameController.text, _passwordController.text);

                if (isResetPassword) {
                  Fluttertoast.showToast(
                    msg: 'Passowrd Reset Successfully.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.purple[900],
                    //timeInSecForIosWeb: 1
                  );
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Problems ..!"),
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
            child: Text(
              "Update",
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
