import 'package:flutter/material.dart';
import 'package:todo_list/domain/dtos/task_dto.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/core/services/toast_provider.dart';
import 'package:todo_list/core/services/uuid_service.dart';
import 'package:todo_list/ui/pages/form_task/form_task_state.dart';

typedef EditCallback<T> = T Function(T entity);

class FormTaskController {
  final TasksProvider _tasksProvider;
  final TaskModel? _taskToEdit;

  FormTaskController({
    required TasksProvider tasksProvider,
    required TaskModel? taskToEdit,
  }) : _tasksProvider = tasksProvider,
       _taskToEdit = taskToEdit {
    initialize();
  }

  ValueNotifier<FormTaskState> stateNotifier = ValueNotifier<FormTaskState>(
    FormTaskStateInitial(buttonIsLoading: false),
  );

  late TaskDto taskDto;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initialize() {
    if (_taskToEdit != null) {
      taskDto = _taskToEdit.toDto();
    } else {
      taskDto = TaskDto.empty();
    }
  }

  Future<void> createTask() async {
    try {
      stateNotifier.value = FormTaskStateInitial(buttonIsLoading: true);

      taskDto = taskDto.copyWith(
        id: UuidService.generateUuid(),
        status: TaskStatusEnum.pending,
      );

      await _tasksProvider.createTask(taskDto.toModel());

      stateNotifier.value = FormTaskStateSuccess();
    } catch (e) {
      toast.showError('Erro ao criar tarefa: $e');
      stateNotifier.value = FormTaskStateInitial(buttonIsLoading: false);
    }
  }

  Future<void> updateTask() async {
    try {
      stateNotifier.value = FormTaskStateInitial(buttonIsLoading: true);

      await _tasksProvider.updateTask(taskDto.toModel());

      stateNotifier.value = FormTaskStateSuccess();
    } catch (e) {
      toast.showError('Erro ao atualizar tarefa: $e');
      stateNotifier.value = FormTaskStateInitial(buttonIsLoading: false);
    }
  }

  void edit(EditCallback<TaskDto> callback) {
    taskDto = callback(taskDto);
  }
}
