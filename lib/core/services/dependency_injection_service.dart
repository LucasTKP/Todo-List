import 'package:get_it/get_it.dart';
import 'package:todo_list/core/providers/tasks_provider.dart';
import 'package:todo_list/data/repositories/task_repository.dart';
import 'package:todo_list/core/services/local_database_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  await getIt.reset();

  getIt.registerLazySingleton(() => LocalDatabaseService());
  getIt.registerLazySingleton(() => TaskRepository(localDatabaseService: getIt<LocalDatabaseService>()));
  getIt.registerLazySingleton(() => TasksProvider(taskRepository: getIt<TaskRepository>()));
}
