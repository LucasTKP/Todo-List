import 'package:flutter/material.dart';

enum TaskStatusEnum {
  pending,
  completed;

  static TaskStatusEnum fromMap(String status) {
    return TaskStatusEnum.values.firstWhere(
      (e) => e.name == status,
      orElse: () => TaskStatusEnum.pending,
    );
  }

  String get displayName {
    switch (this) {
      case TaskStatusEnum.pending:
        return 'Pendente';
      case TaskStatusEnum.completed:
        return 'Concluída';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatusEnum.pending:
        return Colors.orange;
      case TaskStatusEnum.completed:
        return Colors.green;
    }
  }
}
