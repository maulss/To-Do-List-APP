import 'package:flutter/material.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to UpTodo",
              style: TextStyleConstant.lato.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 44,
                right: 44,
                top: 26,
              ),
              child: Text(
                textAlign: TextAlign.center,
                "Please login to your account or create new account to continue",
                style: TextStyleConstant.lato.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 370,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstant.buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyleConstant.lato.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/register_screen');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstant.buttonColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "CREATE ACCOUNT",
                        style: TextStyleConstant.lato.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
