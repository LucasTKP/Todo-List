import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';
import 'package:todo_list/domain/models/task_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final Function() onTap;
  final Function() onDelete;
  final Function() onToggleStatus;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.task.status == TaskStatusEnum.completed;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        key: Key(widget.task.id),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.3,
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                widget.onToggleStatus();
              },
              backgroundColor: isCompleted ? Colors.orange : Colors.green,
              borderRadius: BorderRadius.circular(12),
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCompleted ? Icons.restart_alt_rounded : Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCompleted ? 'Reabrir' : 'Concluir',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.25,
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                widget.onDelete();
              },
              backgroundColor: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(12),
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Excluir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF6366F1).withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.task.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: isCompleted ? const Color(0xFF9CA3AF) : const Color(0xFF1A1A1A),
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildStatusBadge(isCompleted),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isCompleted ? const Color(0xFFBBBBBB) : const Color(0xFF6B7280),
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: isCompleted ? const Color(0xFF9CA3AF) : const Color(0xFF6366F1),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.task.date.toDDMMYYYY(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isCompleted ? const Color(0xFF9CA3AF) : const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isCompleted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF34C759) : const Color(0xFFFF9500),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.schedule,
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            widget.task.status.displayName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
