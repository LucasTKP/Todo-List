sealed class FormTaskState {}

class FormTaskStateInitial extends FormTaskState {
  final bool buttonIsLoading;

  FormTaskStateInitial({required this.buttonIsLoading});
}

class FormTaskStateSuccess extends FormTaskState {}

class FormTaskStateError extends FormTaskState {
  final String message;

  FormTaskStateError({required this.message});
}
