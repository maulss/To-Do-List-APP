import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/controller/profile_controller.dart';

class ProfileSection extends StatefulWidget {
  ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  User? currentuser = FirebaseAuth.instance.currentUser;
  final ProfileController profileController = Get.put(ProfileController());

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetail() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentuser?.email)
        .get();
  }

  String newName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 45,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Profile",
                  style: TextStyleConstant.lato.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: getUserDetail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error : ${snapshot.hasError}");
                    } else if (snapshot.hasData) {
                      var userData = snapshot.data?.data();

                      return Text(
                        "${userData?["name"]}",
                        style: TextStyleConstant.lato.copyWith(
                          fontSize: 20,
                        ),
                      );
                    } else {
                      return Text(
                        "Name is Empty",
                        style: TextStyleConstant.lato.copyWith(
                          fontSize: 20,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 58,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 58,
                        width: 154,
                        decoration: BoxDecoration(
                          color: ColorConstant.navigationFormColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "10 Task Left ",
                          style: TextStyleConstant.lato.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 58,
                        width: 154,
                        decoration: BoxDecoration(
                          color: ColorConstant.navigationFormColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "10 Task Left ",
                          style: TextStyleConstant.lato.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                      "Settings",
                      style: TextStyleConstant.lato.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                ContainerItem(
                  name: "App Settings",
                  nameAsset: "assets/images/setting.png",
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Account",
                      style: TextStyleConstant.lato.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    profileController.editUserName();
                  },
                  child: ContainerItem(
                    name: "Change account name",
                    nameAsset: "assets/images/user.png",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ContainerItem(
                  name: "Change account password",
                  nameAsset: "assets/images/key.png",
                ),
                const SizedBox(
                  height: 8,
                ),
                ContainerItem(
                  name: "Change account Image",
                  nameAsset: "assets/images/camera.png",
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Uptodo",
                      style: TextStyleConstant.lato.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                ContainerItem(
                  name: "About US",
                  nameAsset: "assets/images/menu.png",
                ),
                const SizedBox(
                  height: 8,
                ),
                ContainerItem(
                  name: "FAQ",
                  nameAsset: "assets/images/info-circle.png",
                ),
                const SizedBox(
                  height: 8,
                ),
                ContainerItem(
                  name: "Help & Feedback",
                  nameAsset: "assets/images/flash.png",
                ),
                const SizedBox(
                  height: 8,
                ),
                ContainerItem(
                  name: "Support US",
                  nameAsset: "assets/images/like.png",
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      backgroundColor: ColorConstant.backgroundColor,
                      titleStyle: TextStyleConstant.lato.copyWith(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      title: "Logout",
                      middleTextStyle: TextStyleConstant.lato.copyWith(
                        fontSize: 16,
                      ),
                      middleText: "Are you sure you want to logout ?",
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "No",
                            style: TextStyleConstant.lato,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            logout();
                            Get.offNamed('/login_screen');
                          },
                          child: Text(
                            "Yes",
                            style: TextStyleConstant.lato,
                          ),
                        ),
                      ],
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/logout.png",
                              height: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Logout",
                              style: TextStyleConstant.lato
                                  .copyWith(fontSize: 16, color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  const ContainerItem({super.key, required this.nameAsset, required this.name});
  final String nameAsset;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                nameAsset,
                height: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyleConstant.lato.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
          Image.asset(
            "assets/images/arrow-left.png",
            height: 24,
          )
        ],
      ),
    );
  }
}
