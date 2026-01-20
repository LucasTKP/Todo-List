import 'package:flutter/widgets.dart';
import 'package:todo_list/core/services/toast_provider.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/ui/pages/home/home_state.dart';

class HomeController {
  final TasksProvider _tasksProvider;
  HomeController({required TasksProvider tasksProvider}) : _tasksProvider = tasksProvider {
    listenTasksProvider();
  }

  void listenTasksProvider() {
    _tasksProvider.tasksNotifier.addListener(
      () {
        if (stateNotifier.value is HomeStateLoaded) {
          final currentState = stateNotifier.value as HomeStateLoaded;
          stateNotifier.value = currentState.copyWith(tasks: _tasksProvider.getTasks);
          return;
        }
      },
    );
  }

  void dispose() {
    stateNotifier.dispose();
  }

  ValueNotifier<HomeState> stateNotifier = ValueNotifier(HomeStateInitial());

  Future<void> initializeController() async {
    try {
      stateNotifier.value = HomeStateLoading();
      _tasksProvider.loadAllTasks();
      stateNotifier.value = HomeStateLoaded(tasks: _tasksProvider.getTasks);
    } catch (e) {
      stateNotifier.value = HomeStateError(message: e.toString());
    }
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    try {
      final newStatus = task.status == TaskStatusEnum.completed ? TaskStatusEnum.pending : TaskStatusEnum.completed;
      final updatedTask = task.copyWith(status: newStatus);
      await _tasksProvider.updateTask(updatedTask);
      toast.showSuccess('Tarefa atualizada com sucesso');
    } catch (e) {
      toast.showError('Falha ao atualizar tarefa: ${e.toString()}');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksProvider.deleteTask(taskId);
      toast.showSuccess('Tarefa deletada com sucesso');
    } catch (e) {
      toast.showError('Falha ao deletar tarefa: ${e.toString()}');
    }
  }

  void onChangeFilterStatus(TaskStatusEnum? status) {
    if (stateNotifier.value is HomeStateLoaded) {
      final currentState = stateNotifier.value as HomeStateLoaded;
      stateNotifier.value = currentState.copyWith(filterStatus: () => status);
    }
  }
}
