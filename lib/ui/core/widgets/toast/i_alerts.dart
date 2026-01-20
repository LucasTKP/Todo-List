abstract class IAlerts {
  void showSuccess(String message, {String? label});
  void showInfo(String message, {String? label});
  void showError(String message, {String? label});
}
