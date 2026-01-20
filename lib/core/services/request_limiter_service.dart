import 'dart:developer' as developer;
import 'package:todo_list/core/services/internal_error_service.dart';

class RequestLimiterService {
  RequestLimiterService._();
  static final instance = RequestLimiterService._();

  int maxQuantityRequestsMinute = 300;
  int quantityRequests = 0;
  DateTime lastRequest = DateTime.now();

  void verify({required String action}) {
    final now = DateTime.now();
    final difference = now.difference(lastRequest);

    if (difference.inMinutes >= 1) {
      quantityRequests = 0;
      lastRequest = now;
    }
    developer.log("$quantityRequests  -  $action");

    if (quantityRequests < maxQuantityRequestsMinute) {
      quantityRequests++;
      return;
    }

    throw InternalErrorService(message: "Limite de requisições atingido");
  }
}
