import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<DateTime> currentDate = DateTime.now().obs;

  @override
  void onInit() {
    getUserDetail();
    super.onInit();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetail() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser?.email)
        .get();
  }

  Future<void> addTask(
      String title, String description, DateTime date, int priority) async {
    Map<String, dynamic> dataTask = {
      "title": title,
      "description": description,
      "date": date,
      "priority": priority,
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser?.email)
        .update({
      "task": FieldValue.arrayUnion([dataTask]),
    });
  }

  Future<void> updateTask(
      int indexToUpdate, Map<String, dynamic> newData) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);

    try {
      DocumentSnapshot<Object?> docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('task')) {
          List<dynamic> taskArray = data['task'];

          if (indexToUpdate >= 0 && indexToUpdate < taskArray.length) {
            taskArray[indexToUpdate] = newData;

            await docRef.update({'task': taskArray});
            print('Task updated successfully');
          } else {
            print('Index out of range');
          }
        } else {
          print('Document does not exist or task field is missing');
        }
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(int indexToRemove) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);

    try {
      DocumentSnapshot<Object?> docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('task')) {
          List<dynamic> taskArray = data['task'];

          if (indexToRemove >= 0 && indexToRemove < taskArray.length) {
            taskArray.removeAt(indexToRemove);

            await docRef.update({'task': taskArray});
            print('Task removed successfully');
          } else {
            print('Index out of range');
          }
        } else {
          print('Document does not exist or task field is missing');
        }
      }
    } catch (e) {
      print('Error removing task: $e');
    }
  }
}
