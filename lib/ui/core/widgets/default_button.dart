import 'package:flutter/material.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';
import 'package:todo_list/ui/core/widgets/custom_circular_progress.dart';

class DefaultButton {
  static Widget standard({
    required bool buttonIsLoading,
    required Function onPressed,
    required String label,
    double height = 52,
    Color? color = ThemeColors.primary,
    Widget? icon,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ElevatedButton(
          onPressed: buttonIsLoading
              ? null // Desativa o botão durante o carregamento
              : () => onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: Size(buttonIsLoading ? 100 : constraints.maxWidth, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonIsLoading ? 100 : 6),
            ),
            overlayColor: Colors.white,
          ),
          child: buttonIsLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CustomCircularProgress(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
