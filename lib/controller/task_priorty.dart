import 'package:get/get.dart';

class TaskPriorty extends GetxController {
  RxInt number = 1.obs;
  void increment() {
    if (number < 10) {
      number.value++;
    }
  }

  void decrement() {
    // ignore: unrelated_type_equality_checks
    if (number != 1) {
      number.value--;
    }
  }
}
