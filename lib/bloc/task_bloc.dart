import 'dart:async';

import 'package:jiffy/jiffy.dart';

import '../model/task_model.dart';
import '../repository/task_repository.dart';

class TaskBloc {
  final _taskRepository = TaskRepository();

  TaskBloc() {
    getTasks();
  }

  Future<List<TaskModel>> getTasks({
    String? queryKey,
    String? queryValue,
  }) async {
    return await _taskRepository.getAllTasks(
      queryKey: queryKey,
      queryValue: queryValue,
    );
  }

  Future<List<TaskModel>> getTodayTasks({required DateTime d}) async {
    List<TaskModel> l = await _taskRepository.getAllTasks();
    List<TaskModel> temp = l.where((e) {
      return Jiffy(
            e.start ?? '',
            "E, MMM d, yyyy",
          ).dateTime.isBefore(d) &&
          Jiffy(
            e.finish ?? '',
            "E, MMM d, yyyy",
          ).dateTime.isAfter(d);
    }).toList();
    return temp;
  }

  addTask(TaskModel t) async {
    await _taskRepository.insertTasks(t);
  }

  updateTask(TaskModel t) async {
    await _taskRepository.updateTasks(t);
  }

  deleteTaskById(int id) async {
    _taskRepository.deleteTaskById(id);
  }
}
