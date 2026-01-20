import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/domain/models/task_model.dart';

class TaskDto {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final TaskStatusEnum? status;

  TaskDto({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TaskDto.fromMap(Map<String, dynamic> map) {
    return TaskDto(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      status: TaskStatusEnum.fromMap(map['status']),
    );
  }

  factory TaskDto.empty() {
    return TaskDto(
      id: null,
      title: null,
      description: null,
      date: null,
      status: null,
    );
  }

  TaskModel toModel() {
    return TaskModel(
      id: id!,
      title: title!,
      description: description!,
      date: date!,
      status: status!,
    );
  }

  //copiwith
  TaskDto copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    TaskStatusEnum? status,
  }) {
    return TaskDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
