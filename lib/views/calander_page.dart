import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/task_bloc.dart';
import 'package:flutter_todo_app/constants/app_colors.dart';
import 'package:flutter_todo_app/model/task_model.dart';
import 'package:flutter_todo_app/views/task_form.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _taskBloc = TaskBloc();

  DateTime _selectedDate = DateTime.now();
  CalendarFormat _format = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.1),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
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
            const Divider(),
            Expanded(
              child: FutureBuilder<List<TaskModel>>(
                  future: _taskBloc.getTodayTasks(
                    d: _selectedDate,
                  ),
                  builder: (_, s) {
                    if (s.hasData) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: 120.0,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (cxt, i) {
                          final task = s.data![i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    value: task.isFinished,
                                    onChanged: (value) async {
                                      await _taskBloc.updateTask(
                                        TaskModel(
                                          id: task.id,
                                          title: task.title,
                                          finish: task.finish,
                                          start: task.start,
                                          targetId: task.targetId,
                                          isFinished: value,
                                        ),
                                      );
                                      setState(() {});
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        task.title ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: AppColors.blackColor,
                                          decoration: task.isFinished ?? false
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        '${task.start} '
                                        '- '
                                        '${task.finish}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color:
                                              AppColors.blackColor.withOpacity(
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
                                ),
                                PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  itemBuilder: (_) => [
                                    const PopupMenuItem(
                                      child: Text("Update"),
                                      value: 1,
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Delete"),
                                      value: 2,
                                    ),
                                  ],
                                  onSelected: (value) async {
                                    switch (value) {
                                      case 1:
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (cxt) {
                                            return TaskForm(
                                              onSave: () {
                                                setState(() {});
                                              },
                                              targetId: task.targetId ?? 0,
                                              task: task,
                                            );
                                          },
                                        );
                                        break;
                                      case 2:
                                        await _taskBloc.deleteTaskById(
                                          task.id ?? 0,
                                        );
                                        setState(() {});
                                        break;
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (cxt, i) {
                          return const Divider();
                        },
                        itemCount: s.data!.length,
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
