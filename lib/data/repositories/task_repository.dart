import 'dart:convert';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/core/services/local_database_service.dart';

class TaskRepository {
  final LocalDatabaseService _localDatabaseService;
  static const String _tableName = 'tasks';

  TaskRepository({required LocalDatabaseService localDatabaseService}) : _localDatabaseService = localDatabaseService;

  Future<void> createTask(TaskModel task) async {
    await _localDatabaseService.save(
      table: _tableName,
      id: task.id,
      jsonData: jsonEncode(task.toMap()),
      action: 'create_task',
    );
  }

  Future<void> updateTask(TaskModel task) async {
    await _localDatabaseService.save(
      table: _tableName,
      id: task.id,
      jsonData: jsonEncode(task.toMap()),
      action: 'update_task',
    );
  }

  Future<void> deleteTask(String taskId) async {
    await _localDatabaseService.delete(
      table: _tableName,
      id: taskId,
      action: 'delete_task',
    );
  }

  Future<List<TaskModel>> getAllTasks() async {
    final allTasks = await _localDatabaseService.getAll(
      table: _tableName,
      action: 'get_all_tasks',
    );

    final tasks = allTasks.map((taskData) => TaskModel.fromMap(taskData)).toList();
    tasks.sort((a, b) => a.date.compareTo(b.date));
    return tasks;
  }
}
