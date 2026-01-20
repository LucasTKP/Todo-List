import 'dart:async';
import 'package:todo_list/core/services/internal_error_service.dart';

String identifyError({required dynamic error, required String message}) {
  String messageError = message;

  if (error is TimeoutException) {
    return 'Tempo esgotado.\nVerifique sua conexão com a internet.';
  }

  if (error is TypeError) {
    return 'Erro de tipo.';
  }

  if (error is InternalErrorService) {
    messageError = error.message;
  }

  return messageError;
}
