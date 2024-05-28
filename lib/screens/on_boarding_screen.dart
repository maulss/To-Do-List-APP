import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/utils/shared_pref.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonTextStyle: TextStyleConstant.lato.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        controllerColor: Colors.white,
        centerBackground: true,
        pageBackgroundColor: ColorConstant.backgroundColor,
        headerBackgroundColor: ColorConstant.backgroundColor,
        onFinish: () {
          SharedPref.seenOrBoarding();
          Navigator.pushReplacementNamed(context, "/welcome_screen");
        },
        finishButtonText: 'Get Started',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: ColorConstant.buttonColor,
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyleConstant.lato.copyWith(
            fontSize: 16,
          ),
        ),
        trailing: const Text(
          '',
        ),
        background: [
          Image.asset(
            "assets/images/Group 182.png",
            height: 277,
          ),
          Image.asset(
            "assets/images/Frame 162.png",
            height: 277,
          ),
          Image.asset(
            "assets/images/Frame 161.png",
            height: 277,
          ),
        ],
        totalPage: 3,
        speed: 2,
        pageBodies: const [
          OnBoardingItem(
            title: "Manage your tasks",
            subTitle:
                "You can easily manage all of your daily tasks in UpTodo for free",
          ),
          OnBoardingItem(
            title: "Create daily routine",
            subTitle:
                "In Uptodo  you can create your personalized routine to stay productive",
          ),
          OnBoardingItem(
            title: "Organize your tasks",
            subTitle:
                "You can organize your daily tasks by adding your tasks into separate categories",
          ),
        ],
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyleConstant.lato.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 42,
            bottom: 180,
            left: 20,
            right: 20,
          ),
          child: Text(
            textAlign: TextAlign.center,
            subTitle,
            style: TextStyleConstant.lato.copyWith(
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
