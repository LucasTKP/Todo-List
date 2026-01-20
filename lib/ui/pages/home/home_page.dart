import 'package:flutter/material.dart';
import 'package:todo_list/domain/enums/task_status_enum.dart';
import 'package:todo_list/core/services/dependency_injection_service.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/ui/core/widgets/custom_drop_down.dart';
import 'package:todo_list/ui/core/widgets/default_screen.dart';
import 'package:todo_list/ui/core/widgets/generic_error_screen.dart';
import 'package:todo_list/ui/pages/form_task/form_task_page.dart';
import 'package:todo_list/ui/pages/home/home_controller.dart';
import 'package:todo_list/ui/pages/home/home_state.dart';
import 'package:todo_list/ui/pages/home/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(tasksProvider: getIt<TasksProvider>());
    _controller.initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToCreateTask() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FormTaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      titleAppBar: 'Minhas Tarefas',
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ValueListenableBuilder(
          valueListenable: _controller.stateNotifier,
          builder: (context, state, _) {
            if (state is HomeStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeStateError) {
              return GenericErrorScreen(
                tryAgain: () {
                  _controller.initializeController();
                },
              );
            }

            if (state is HomeStateLoaded) {
              final tasks = state.filteredTasks;
              final hasNoTasks = state.tasks.isEmpty;

              // Nenhuma tarefa cadastrada
              if (hasNoTasks) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 80, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma tarefa cadastrada',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Clique no botão + para adicionar sua primeira tarefa.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              // Há tarefas cadastradas
              return Column(
                children: [
                  // Dropdown sempre aparece se houver tarefas cadastradas
                  CustomDropDown(
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text('Todos'),
                      ),
                      ...TaskStatusEnum.values.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.displayName,
                            style: TextStyle(color: e.color),
                          ),
                        ),
                      ),
                    ],
                    labelText: 'Filtrar por status',
                    hintText: 'Selecione o status ex: Pendente',
                    onChanged: (value) {
                      _controller.onChangeFilterStatus(value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Verifica se o filtro retornou resultados
                  if (tasks.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_list_off, size: 80, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhuma tarefa encontrada',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tente ajustar o filtro para ver suas tarefas.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) {
                          final task = tasks[idx];
                          return TaskCard(
                            task: task,
                            onToggleStatus: () async {
                              await _controller.toggleTaskStatus(task);
                            },
                            onDelete: () async {
                              await _controller.deleteTask(task.id);
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return FormTaskPage(taskToEdit: task);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
