import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_list/ui/core/themes/extensions.dart';
import 'package:todo_list/ui/core/widgets/toast/i_alerts.dart';

class Toast implements IAlerts {
  final BuildContext context;
  Toast._(this.context);

  factory Toast.of(BuildContext context) {
    return Toast._(context);
  }
  late final Toastification? toast;

  @override
  void showError(String message, {String? label, Alignment? alignment, Duration? duration}) => _showMessage(
    label: label,
    message: message,
    color: const Color(0xFFD32F2F),
    alignment: alignment,
    duration: duration,
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
  );

  @override
  void showInfo(String message, {String? label, Alignment? alignment, Duration? duration}) => _showMessage(
    label: label,
    message: message,
    duration: duration,
    color: const Color(0xFF1D594E),
    alignment: alignment,
    icon: const Icon(
      Icons.info_outline,
      color: Colors.white,
    ),
  );

  @override
  void showSuccess(
    String message, {
    String? label,
    Alignment? alignment,
    Duration? duration,
  }) => _showMessage(
    label: label ?? "Sucesso",
    message: message,
    duration: duration,
    color: const Color(0xFF388E3C),
    alignment: alignment ?? Alignment.topCenter,
    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
  );

  Duration calculeDuration(String message) {
    final int lenght = message.split(" ").length;
    final int miliseconds = lenght * 400;
    if (miliseconds < 4000) return const Duration(seconds: 4);
    return Duration(milliseconds: miliseconds);
  }

  void _showMessage({
    String? label,
    String? message,
    required Color color,
    Widget? icon,
    Color? backGroundColor,
    Alignment? alignment,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      title: label == null
          ? null
          : Text(
              label,
              maxLines: null,
              style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      backgroundColor: backGroundColor ?? const Color(0xFF1D594E),
      primaryColor: color,
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      dragToClose: true,
      alignment: alignment ?? Alignment.topLeft,
      showProgressBar: true,
      boxShadow: [],
      description: message == null
          ? null
          : Text(
              message,
              maxLines: null,
              style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
            ),
      icon: icon,
      pauseOnHover: true,
      progressBarTheme: ProgressIndicatorThemeData(
        color: Colors.white,
        linearTrackColor: Colors.grey.shade400,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
