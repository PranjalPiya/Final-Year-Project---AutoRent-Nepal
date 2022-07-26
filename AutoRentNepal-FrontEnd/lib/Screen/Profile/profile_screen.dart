// ignore_for_file: avoid_unnecessary_containers

//import 'dart:html';

import 'package:auto_rent_nepal_fyp/Screen/Profile/profile_body.dart';

import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';

// class UserProfile extends StatefulWidget {
//   static const routeName = '/userprofile-screens';

//   const UserProfile({Key? key}) : super(key: key);

//   @override
//   _UserProfileState createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {

// }
class ProfileScreen extends StatelessWidget {
  final title;
  static const routeName = '/userprofile-screens';
  const ProfileScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: AppColor.CREAM,
      body: ProfileBody(),
    );
  }
}
// class Profile extends StatelessWidget {
 
//   const Profile({Key? key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
