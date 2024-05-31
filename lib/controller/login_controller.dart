import 'package:get/get.dart';

class LoginController extends GetxController {
  final erorMessageEmail = Rxn<String>();
  final erorMessagePassword = Rxn<String>();

  void checkName(String value) {
    if (value.isEmpty) {
      erorMessageEmail.value = "Email cannot be empty";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      erorMessageEmail.value = "Enter a valid email";
    } else {
      erorMessageEmail.value = null;
    }
  }

  void checkPassword(String value) {
    if (value.isEmpty) {
      erorMessagePassword.value = "Password cannot be empty";
    } else if (value.length < 3) {
      erorMessagePassword.value = "Password must be at least 3 characters";
    } else {
      erorMessagePassword.value = null;
    }
  }
}
