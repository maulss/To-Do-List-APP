import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/screens/widgets/form_widget.dart';
import 'package:todo_app/helper.dart/message_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final fireAuth = FirebaseAuth.instance;

  void register() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential? userCredential =
          await fireAuth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      createUserDocument(userCredential);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      const snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          'Register succes',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, '/login_screen');
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        displaMessageUser("Email already in use", context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential?.user!.email)
        .set({
      "email": userCredential!.user?.email,
      "name": userNameController.text,
      "task": [],
      "image": '',
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isObsecure = true;

  String? nameError;
  String? emailError;
  String? passwordError;

  void checkName(String value) {
    setState(() {
      if (value.isEmpty) {
        nameError = 'Name cannot be empty';
      } else if (value.length < 3) {
        nameError = 'Name must be at least 3 characters';
      } else {
        nameError = null;
      }
    });
  }

  void checkEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        emailError = 'Email cannot be empty';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        emailError = 'Enter a valid email';
      } else {
        emailError = null;
      }
    });
  }

  void checkPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordError = 'Password cannot be empty';
      } else if (value.length < 3) {
        passwordError = 'Password must be at least 3 characters';
      } else {
        passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              "Register",
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
                  FormWidget(
                    obscureText: false,
                    controller: userNameController,
                    labelText: "Name",
                    onChanged: checkName,
                    errorText: nameError,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormWidget(
                    errorText: emailError,
                    onChanged: checkEmail,
                    obscureText: false,
                    controller: emailController,
                    labelText: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormWidget(
                    onChanged: checkPassword,
                    errorText: passwordError,
                    obscureText: isObsecure,
                    controller: passwordController,
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon: Icon(
                          isObsecure ? Icons.visibility : Icons.visibility_off,
                        )),
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
                        width: 180,
                        child: Text(
                          "already have an account?",
                          style: TextStyleConstant.lato,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/login_screen');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 35,
                          child: Text(
                            "Login",
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
                      if (nameError != null ||
                          emailError != null ||
                          passwordError != null) {
                        const snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'Fix the form',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        register();
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
                        "Register",
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
