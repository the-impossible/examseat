import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:exam_seat_arrangement/main.dart';
import 'package:exam_seat_arrangement/models/user_response.dart';
import 'package:exam_seat_arrangement/screens/exam_officer/examOfficerNavbar.dart';
import 'package:exam_seat_arrangement/screens/login.dart';
import 'package:exam_seat_arrangement/screens/student/bottomNavbar.dart';
import 'package:exam_seat_arrangement/services/remote_services.dart';
import 'package:exam_seat_arrangement/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserDetailsResponse? user;
  var check_login = 0;

  // Fetch user data and set check_login accordingly
  Future<void> nextScreen(BuildContext context) async {
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      UserDetailsResponse? user = await RemoteServices.userResponse(context);
      if (user != null) {
        setState(() {
          if (user.isExamofficer) {
            check_login = 1;
          } else if (user.isInvigilator || user.isStudent) {
            check_login = 2;
          } else {
            check_login = 0;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            Constants.snackBar(context, "Invalid User", false));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nextScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset("assets/images/logo.png",
                  width: 250, height: 250),
            )
          ],
        ),
      ),
      backgroundColor: Constants.backgroundColor,
      splashIconSize: 300.0,
      nextScreen: check_login == 1
          ? const ExamOfficerNavbar()
          : check_login == 2
              ? const Navbar()
              : const Login(),
      // You can add a splashTransition to customize transition effects if needed
      splashTransition: SplashTransition.fadeTransition,
      // You can specify the duration of the splash screen if needed
      duration: 3000,
      // You can specify additional settings as needed
    );
  }
}
