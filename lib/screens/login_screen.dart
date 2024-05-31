import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/controller/login_controller.dart';
import 'package:todo_app/screens/widgets/form_widget.dart';
import 'package:todo_app/helper.dart/message_helper.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final fireAuth = FirebaseAuth.instance;
  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await fireAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
      Get.offNamed("/home_screen");
      // Navigator.pushReplacementNamed(context, '/home_screen');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displaMessageUser(e.code, context);
    }
  }

  bool isObsecure = true;

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    print("page ini di rebuild");
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon_logo.png",
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Login",
              style: TextStyleConstant.lato.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  Obx(() {
                    return FormWidget(
                      onChanged: loginController.checkName,
                      errorText: loginController.erorMessageEmail.value,
                      obscureText: false,
                      controller: emailController,
                      labelText: "Email",
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => FormWidget(
                      onChanged: loginController.checkPassword,
                      errorText: loginController.erorMessagePassword.value,
                      obscureText: isObsecure,
                      controller: passwordController,
                      labelText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                isObsecure = !isObsecure;
                              },
                            );
                          },
                          icon: Icon(
                            isObsecure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 150,
                        child: Text(
                          "don't have an account?",
                          style: TextStyleConstant.lato,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/register_screen');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 60,
                          child: Text(
                            "Register",
                            style: TextStyleConstant.lato
                                .copyWith(color: ColorConstant.buttonColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (loginController.erorMessageEmail.value != null ||
                          loginController.erorMessagePassword.value != null) {
                        const snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'Fix the form',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        login();
                      }
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
                        "Login",
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
