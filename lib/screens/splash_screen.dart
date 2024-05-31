import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constants/text_style_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seeOnBoarding = prefs.getBool('seenOrboarding');
    User? user = FirebaseAuth.instance.currentUser;
    print(user?.email);

    if (seeOnBoarding == null) {
      Navigator.pushReplacementNamed(context, '/on_boarding');
    } else if (user != null) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    } else {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon_logo.png",
              height: 80,
            ),
            const SizedBox(
              height: 19,
            ),
            Text(
              "UpTodo",
              style: TextStyleConstant.lato.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
