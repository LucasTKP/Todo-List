import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/domain/models/task_model.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<TaskModel> tasks;
  final TaskStatusEnum? filterStatus;
  HomeStateLoaded({
    required this.tasks,
    this.filterStatus,
  });

  List<TaskModel> get filteredTasks {
    if (filterStatus == null) {
      return tasks;
    }
    return tasks.where((task) => task.status == filterStatus).toList();
  }

  HomeStateLoaded copyWith({
    List<TaskModel>? tasks,
    ValueGetter<TaskStatusEnum?>? filterStatus,
  }) {
    return HomeStateLoaded(
      tasks: tasks ?? this.tasks,
      filterStatus: filterStatus != null ? filterStatus() : this.filterStatus,
    );
  }

  @override
  List<Object?> get props => [tasks, filterStatus, tasks.length];
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError({required this.message});
}
