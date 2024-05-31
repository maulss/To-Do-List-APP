import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final RxString newvalue = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserName();
  }

  Future<void> fetchCurrentUserName() async {
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await userCollection.doc(currentUser!.email).get();
      if (userDoc.exists) {
        newvalue.value = userDoc['name'] ?? "";
      }
    }
  }

  Future<void> editUserName() async {
    await Get.defaultDialog(
      title: "Edit Name",
      content: TextFormField(
        initialValue: newvalue.value,
        onChanged: (value) {
          newvalue.value = value;
        },
        decoration: InputDecoration(hintText: "Enter Name"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            print(newvalue.value);
            await userCollection.doc(currentUser?.email).update(
              {"name": newvalue.value},
            );
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
