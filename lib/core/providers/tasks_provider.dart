import 'package:flutter/material.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/data/repositories/task_repository.dart';

class TasksProvider {
  final TaskRepository _taskRepository;

  TasksProvider({required TaskRepository taskRepository}) : _taskRepository = taskRepository;

  ValueNotifier<List<TaskModel>> tasksNotifier = ValueNotifier([]);

  List<TaskModel> get getTasks {
    return tasksNotifier.value;
  }

  Future<void> loadAllTasks() async {
    final allTasks = await _taskRepository.getAllTasks();
    tasksNotifier.value = allTasks;
  }

  Future<void> createTask(TaskModel task) async {
    await _taskRepository.createTask(task);
    final currentTasks = List<TaskModel>.from(tasksNotifier.value);
    currentTasks.add(task);
    currentTasks.sort((a, b) => a.date.compareTo(b.date));
    tasksNotifier.value = currentTasks;
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskRepository.updateTask(task);
    final currentTasks = List<TaskModel>.from(tasksNotifier.value);
    final index = currentTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      currentTasks[index] = task;
      currentTasks.sort((a, b) => a.date.compareTo(b.date));
      tasksNotifier.value = currentTasks;
    }
  }

  Future<void> deleteTask(String taskId) async {
    await _taskRepository.deleteTask(taskId);
    final currentTasks = List<TaskModel>.from(tasksNotifier.value);
    currentTasks.removeWhere((t) => t.id == taskId);
    tasksNotifier.value = currentTasks;
  }

  void dispose() {
    tasksNotifier.dispose();
  }
}
