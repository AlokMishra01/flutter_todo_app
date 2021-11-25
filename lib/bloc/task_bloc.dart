import 'dart:async';

import '../model/task_model.dart';
import '../repository/task_repository.dart';

class TaskBloc {
  final _taskRepository = TaskRepository();

  final _taskController = StreamController<List<TaskModel>>.broadcast();

  get tasks => _taskController.stream;

  TaskBloc() {
    getTasks();
  }

  getTasks({
    String? queryKey,
    String? queryValue,
  }) async {
    _taskController.sink.add(
      await _taskRepository.getAllTasks(
        queryKey: queryKey,
        queryValue: queryValue,
      ),
    );
  }

  addTask(TaskModel t) async {
    await _taskRepository.insertTasks(t);
    getTasks(queryKey: 'targetId', queryValue: '${t.targetId}');
  }

  updateTask(TaskModel t) async {
    await _taskRepository.updateTasks(t);
    getTasks(queryKey: 'targetId', queryValue: '${t.targetId}');
  }

  deleteTaskById(int id) async {
    _taskRepository.deleteTaskById(id);
    getTasks();
  }
}
