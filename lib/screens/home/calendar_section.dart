import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/text_style_constant.dart';
import 'package:todo_app/controller/home_controller.dart'; // Import HomeController

class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _homeController.currentDate.value = selectedDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 3, 14),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
                if (_homeController.currentDate.value == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: _homeController.getUserDetail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data?.data() == null) {
                        return Center(child: Text('No tasks found'));
                      }

                      List<dynamic> tasks =
                          snapshot.data!.data()!['task'] ?? [];

                      List<dynamic> selectedDateTasks = tasks.where((task) {
                        DateTime taskDate =
                            (task['date'] as Timestamp).toDate();
                        return isSameDay(taskDate, _selectedDay);
                      }).toList();

                      if (selectedDateTasks.isEmpty) {
                        return Center(
                            child: Text('No tasks for selected date'));
                      }

                      return ListView.builder(
                        itemCount: selectedDateTasks.length,
                        itemBuilder: (context, index) {
                          var task = selectedDateTasks[index];
                          // return ListTile(
                          //   title: Text(task['title']),
                          //   subtitle: Text(task['description']),
                          // );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 15),
                              height: 72,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorConstant.navigationFormColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    task['title'],
                                    style: TextStyleConstant.lato.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    task['description'],
                                    style: TextStyleConstant.lato
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
