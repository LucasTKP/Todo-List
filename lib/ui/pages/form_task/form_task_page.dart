import 'package:flutter/material.dart';
import 'package:todo_list/core/extensions/datetime_extension.dart';
import 'package:todo_list/core/extensions/string_extension.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/core/services/dependency_injection_service.dart';
import 'package:todo_list/core/services/toast_provider.dart';
import 'package:todo_list/ui/core/widgets/custom_input_date.dart';
import 'package:todo_list/ui/core/widgets/custom_inputs.dart';
import 'package:todo_list/ui/core/widgets/default_button.dart';
import 'package:todo_list/ui/core/widgets/default_screen.dart';
import 'package:todo_list/ui/pages/form_task/form_task_controller.dart';
import 'package:todo_list/ui/pages/form_task/form_task_state.dart';

class FormTaskPage extends StatefulWidget {
  final TaskModel? taskToEdit;
  const FormTaskPage({super.key, this.taskToEdit});

  @override
  State<FormTaskPage> createState() => _FormTaskPageState();
}

class _FormTaskPageState extends State<FormTaskPage> {
  late final FormTaskController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FormTaskController(
      tasksProvider: getIt<TasksProvider>(),
      taskToEdit: widget.taskToEdit,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_controller.formKey.currentState?.validate() ?? false) {
      if (widget.taskToEdit == null) {
        await _controller.createTask();
      } else {
        await _controller.updateTask();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      titleAppBar: widget.taskToEdit == null ? 'Nova Tarefa' : 'Editar Tarefa',
      body: ValueListenableBuilder(
        valueListenable: _controller.stateNotifier,
        builder: (context, value, child) {
          if (value is FormTaskStateSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              toast.showSuccess('Tarefa criada com sucesso!');
              Navigator.of(context).pop(true);
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CustomInputs.standard(
                    label: 'Título',
                    maxLength: 100,
                    initialValue: _controller.taskDto.title,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.title,
                    hintText: 'Digite o título da tarefa',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Título é obrigatório';
                      }
                      if (value.trim().length < 3) {
                        return 'Título deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _controller.edit((task) => task.copyWith(title: value));
                    },
                  ),

                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      CustomInputs.standard(
                        label: 'Descrição',
                        maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        initialValue: _controller.taskDto.description,
                        hintText: 'Digite a descrição da tarefa',
                        maxLines: 5,
                        buildCounter: true,
                        contentPadding: const EdgeInsets.only(left: 40, top: 16, right: 16, bottom: 16),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Descrição é obrigatória';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          _controller.edit((task) => task.copyWith(description: value));
                        },
                      ),
                      const Positioned(
                        left: 10,
                        top: 18,
                        child: Icon(Icons.description, color: Color(0xFF1D594E)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  InputDate(
                    labelText: 'Data',
                    hintText: 'Selecione a data da tarefa',
                    prefixIcon: Icons.calendar_today,
                    initialValue: _controller.taskDto.date?.toDDMMYYYY(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    dataSelecionada: _controller.taskDto.date,
                    value: _controller.taskDto.date?.toDDMMYYYY(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data é obrigatória';
                      }
                      return null;
                    },
                    onChanged: (dateString) {
                      final date = dateString.fromDDMMYYYY();
                      if (date != null) {
                        _controller.edit((task) => task.copyWith(date: date));
                      }
                    },
                  ),

                  const SizedBox(height: 32),

                  DefaultButton.standard(
                    onPressed: _handleSubmit,
                    label: 'Salvar Tarefa',
                    buttonIsLoading: value is FormTaskStateInitial ? value.buttonIsLoading : false,
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
