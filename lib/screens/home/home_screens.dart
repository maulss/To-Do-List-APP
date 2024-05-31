import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/controller/home_controller.dart';

import 'package:todo_app/controller/task_priorty.dart';
import 'package:todo_app/screens/home/calendar_section.dart';
import 'package:todo_app/screens/home/home_section.dart';
import 'package:todo_app/screens/home/profile_section.dart';

class HomeScreens extends StatefulWidget {
  HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int selected = 0;

  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  DateTime currentDate = DateTime.now();

  final TaskPriorty taskPriorty = Get.put(TaskPriorty());
  final HomeController homeController = Get.put(HomeController());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      extendBody: true,
      bottomNavigationBar: StylishBottomBar(
        fabLocation: StylishBarFabLocation.center,
        backgroundColor: ColorConstant.navigationFormColor,
        option: AnimatedBarOptions(),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey,
            title: Text(
              'Home',
              style: TextStyleConstant.lato,
            ),
          ),
          BottomBarItem(
            icon: const Icon(Icons.calendar_month),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey,
            title: Text(
              'Calendar',
              style: TextStyleConstant.lato,
            ),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.time_to_leave_outlined,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey,
            title: Text(
              'Focus',
              style: TextStyleConstant.lato,
            ),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.person_outline,
            ),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey,
            title: Text(
              'Profile',
              style: TextStyleConstant.lato,
            ),
          ),
        ],
        currentIndex: selected,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            Container(
              height: 228,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorConstant.navigationFormColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Taks",
                      style: TextStyleConstant.lato.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 43,
                      width: double.infinity,
                      child: TextField(
                        controller: titleController,
                        style: TextStyleConstant.lato,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyleConstant.lato.copyWith(
                            fontSize: 16,
                          ),
                          hintText: "Title",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 43,
                      width: double.infinity,
                      child: TextField(
                        controller: descriptionController,
                        style: TextStyleConstant.lato,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyleConstant.lato.copyWith(
                            fontSize: 16,
                          ),
                          hintText: "Description",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickdate = await showDatePicker(
                                  context: context,
                                  firstDate: currentDate,
                                  lastDate: DateTime(currentDate.year + 5),
                                );
                                if (pickdate != null) {
                                  setState(() {
                                    currentDate = pickdate;
                                    print(currentDate);
                                  });
                                }
                              },
                              child: Icon(
                                Icons.calendar_month,
                                size: 24,
                                color: Color.fromARGB(255, 196, 190, 190),
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                  title: "Task Priorty",
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          taskPriorty.decrement();
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Obx(
                                        () => Text(
                                          "${taskPriorty.number.value}",
                                          style:
                                              TextStyleConstant.lato.copyWith(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            taskPriorty.increment();
                                          },
                                          icon: Icon(Icons.add)),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        taskPriorty.number.value = 1;
                                        Get.back();
                                        print("${taskPriorty.number.value}");
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        print("${taskPriorty.number.value}");
                                      },
                                      child: Text("Save"),
                                    )
                                  ],
                                );
                              },
                              child: Image.asset(
                                "assets/images/flag.png",
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            homeController.addTask(
                              titleController.text,
                              descriptionController.text,
                              currentDate,
                              taskPriorty.number.value,
                            );
                            titleController.clear();
                            descriptionController.clear();
                            setState(() {
                              currentDate = DateTime.now();
                              taskPriorty.number.value = 1;
                            });
                            Get.back();
                          },
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 24,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorConstant.buttonColor,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            HomeSection(),
            CalendarSection(),
            Center(
              child: Text(
                'Focus',
                style: TextStyleConstant.lato,
              ),
            ),
            ProfileSection(),
          ],
        ),
      ),
    );
  }
}
