import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _format = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Calendar',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            TableCalendar(
              currentDay: _selectedDate,
              focusedDay: _selectedDate,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              calendarFormat: _format,
              onFormatChanged: (format) {
                _format = format;
                setState(() {});
              },
              onDaySelected: (selectedDay, focusedDay) {
                _selectedDate = selectedDay;
                setState(() {});
              },
            ),
            Divider(),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: 120.0,
                ),
                shrinkWrap: true,
                itemBuilder: (cxt, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: CheckboxListTile(
                      value: true,
                      onChanged: (value) {},
                      title: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          'UI Design',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: AppColors.blackColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          '09:00 AM 01 Nov - 17:00 AM 02 Nov',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: AppColors.blackColor.withOpacity(
                              0.6,
                            ),
                          ),
                        ),
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      checkColor: AppColors.whiteColor,
                      activeColor: AppColors.greenColor,
                    ),
                  );
                },
                separatorBuilder: (cxt, i) {
                  return Divider();
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
