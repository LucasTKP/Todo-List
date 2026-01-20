import 'package:todo_list/domain/dtos/task_dto.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TaskStatusEnum status;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      status: TaskStatusEnum.fromMap(map['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'status': status.name,
    };
  }

  // CopyWith method to create a new instance with modified fields
  TaskModel copyWith({
    TaskStatusEnum? status,
  }) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      date: date,
      status: status ?? this.status,
    );
  }

  TaskDto toDto() {
    return TaskDto(
      id: id,
      title: title,
      description: description,
      date: date,
      status: status,
    );
  }
}
