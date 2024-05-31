import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/controller/task_priorty.dart';

class HomeSection extends StatelessWidget {
  HomeSection({super.key});

  final HomeController homeController = Get.put(HomeController());
  final TaskPriorty taskPriorty = Get.put(TaskPriorty());

  @override
  Widget build(BuildContext context) {
    homeController.onInit;
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 45,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/sort.png",
                  height: 42,
                ),
                Text(
                  "Home",
                  style: TextStyleConstant.lato.copyWith(
                    fontSize: 20,
                  ),
                ),
                FutureBuilder(
                  future: homeController.getUserDetail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error : ${snapshot.hasError}"),
                      );
                    } else if (snapshot.hasData) {
                      var userData = snapshot.data?.data();
                      if (userData?["image"] != null) {
                        return Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                userData?["image"],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 42,
                          width: 42,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        );
                      }
                    } else {
                      return Text("eror");
                    }
                  },
                ),
              ],
            ),
            FutureBuilder(
              future: homeController.getUserDetail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.hasError}"),
                  );
                } else if (snapshot.hasData) {
                  var userData = snapshot.data?.data();
                  if (userData?["task"].length != 0) {
                    return Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            height: 48,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                hintStyle: TextStyleConstant.lato.copyWith(
                                  fontSize: 16,
                                ),
                                hintText: "Search Task",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: userData?["task"].length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  height: 72,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.navigationFormColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 51,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/flag.png",
                                                    height: 25,
                                                  ),
                                                  Text(
                                                    "${userData?["task"][index]["priority"]}",
                                                    style: TextStyleConstant
                                                        .lato
                                                        .copyWith(
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${userData?["task"][index]["title"]}",
                                                  style: TextStyleConstant.lato
                                                      .copyWith(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 200,
                                                  child: Text(
                                                    "${userData?["task"][index]["description"]}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyleConstant.lato,
                                                    softWrap: false,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              Container(
                                                alignment: Alignment.center,
                                                height: 228,
                                                decoration: const BoxDecoration(
                                                  color: ColorConstant
                                                      .navigationFormColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Text(
                                                          "Mark Task Done",
                                                          style:
                                                              TextStyleConstant
                                                                  .lato
                                                                  .copyWith(
                                                            color: Colors.green,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            Container(
                                                              height: 228,
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: ColorConstant
                                                                    .navigationFormColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 24,
                                                                  right: 24,
                                                                  top: 24,
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Update Taks",
                                                                      style: TextStyleConstant
                                                                          .lato
                                                                          .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          14,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          43,
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            homeController.titleController,
                                                                        style: TextStyleConstant
                                                                            .lato,
                                                                        cursorColor:
                                                                            Colors.white,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintStyle: TextStyleConstant
                                                                              .lato
                                                                              .copyWith(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                          hintText:
                                                                              "Title",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          43,
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            homeController.descriptionController,
                                                                        style: TextStyleConstant
                                                                            .lato,
                                                                        cursorColor:
                                                                            Colors.white,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintStyle: TextStyleConstant
                                                                              .lato
                                                                              .copyWith(
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                          hintText:
                                                                              "Description",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                DateTime? pickdate = await showDatePicker(
                                                                                  context: context,
                                                                                  firstDate: homeController.currentDate.value,
                                                                                  lastDate: DateTime(homeController.currentDate.value.year + 5),
                                                                                );
                                                                                if (pickdate != null) {
                                                                                  homeController.currentDate.value = pickdate;
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
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                                                          style: TextStyleConstant.lato.copyWith(
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
                                                                          onTap:
                                                                              () {
                                                                            homeController.updateTask(index, {
                                                                              "title": homeController.titleController.text,
                                                                              "description": homeController.descriptionController.text,
                                                                              "date": homeController.currentDate.value,
                                                                              "priority": taskPriorty.number.value,
                                                                            });
                                                                            homeController.titleController.clear();
                                                                            homeController.descriptionController.clear();
                                                                            homeController.currentDate.value =
                                                                                DateTime.now();
                                                                            taskPriorty.number.value =
                                                                                1;
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/send.png",
                                                                            height:
                                                                                24,
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
                                                          alignment:
                                                              Alignment.center,
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.yellow,
                                                              width: 1.5,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            "Update Task",
                                                            style:
                                                                TextStyleConstant
                                                                    .lato
                                                                    .copyWith(
                                                              color:
                                                                  Colors.yellow,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          homeController
                                                              .deleteTask(
                                                                  index);
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors.red,
                                                              width: 1.5,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            "Detele Task",
                                                            style:
                                                                TextStyleConstant
                                                                    .lato
                                                                    .copyWith(
                                                              color: Colors.red,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.more_vert,
                                            size: 26,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 75,
                          ),
                          SizedBox(
                            width: 227,
                            height: 227,
                            child: Image.asset(
                              "assets/images/image_kosoong.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "What do you want to do today ?",
                            style: TextStyleConstant.lato.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tap + to add your tasks",
                            style: TextStyleConstant.lato.copyWith(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return Text("Something wrong");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
