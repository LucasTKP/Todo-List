import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/ui/pages/form_task/form_task_controller.dart';
import 'package:todo_list/ui/pages/form_task/form_task_state.dart';

// Mock classes
class MockTasksProvider extends Mock implements TasksProvider {}

void main() {
  late MockTasksProvider mockTasksProvider;
  late FormTaskController controller;

  setUpAll(() {
    registerFallbackValue(
      TaskModel(
        id: 'fallback_id',
        title: 'fallback_title',
        description: 'fallback_desc',
        date: DateTime(2024),
        status: TaskStatusEnum.pending,
      ),
    );
  });

  setUp(() {
    mockTasksProvider = MockTasksProvider();
  });

  tearDown(() {
    controller.stateNotifier.dispose();
  });

  group('FormTaskController - Testes de Criação de Tarefa', () {
    test('Deve criar uma nova tarefa com sucesso', () async {
      // Arrange
      controller = FormTaskController(
        tasksProvider: mockTasksProvider,
        taskToEdit: null,
      );

      controller.edit(
        (dto) => dto.copyWith(
          title: 'Nova Tarefa',
          description: 'Descrição da tarefa',
          date: DateTime(2024, 12, 31),
        ),
      );

      when(() => mockTasksProvider.createTask(any())).thenAnswer((_) async => Future.value());

      await controller.createTask();

      expect(controller.stateNotifier.value, isA<FormTaskStateSuccess>());
      verify(() => mockTasksProvider.createTask(any())).called(1);
      expect(controller.taskDto.title, 'Nova Tarefa');
      expect(controller.taskDto.status, TaskStatusEnum.pending);
    });
  });

  group('FormTaskController - Testes de Edição de Tarefa', () {
    test('Deve atualizar uma tarefa existente com sucesso', () async {
      // Arrange
      final taskToEdit = TaskModel(
        id: '123',
        title: 'Tarefa Original',
        description: 'Descrição original',
        date: DateTime(2024, 12, 31),
        status: TaskStatusEnum.pending,
      );

      controller = FormTaskController(
        tasksProvider: mockTasksProvider,
        taskToEdit: taskToEdit,
      );

      controller.edit(
        (dto) => dto.copyWith(
          title: 'Tarefa Atualizada',
        ),
      );
      when(() => mockTasksProvider.updateTask(any())).thenAnswer((_) async => Future.value());

      await controller.updateTask();

      expect(controller.stateNotifier.value, isA<FormTaskStateSuccess>());
      verify(() => mockTasksProvider.updateTask(any())).called(1);
      expect(controller.taskDto.title, 'Tarefa Atualizada');
      expect(controller.taskDto.id, '123');
    });
  });
}
