import '../dao/task_dao.dart';
import '../model/task_model.dart';

class TaskRepository {
  final taskDao = TaskDao();

  Future<List<TaskModel>> getAllTasks({String? queryKey, String? queryValue}) =>
      taskDao.getTasks(
        queryKey: queryKey,
        queryParameter: queryValue,
      );

  Future insertTasks(TaskModel task) => taskDao.createTask(task);

  Future updateTasks(TaskModel task) => taskDao.updateTasks(task);

  Future deleteTaskById(int id) => taskDao.deleteTask(id);

  Future deleteAllTasks() => taskDao.deleteAllTasks();
}
