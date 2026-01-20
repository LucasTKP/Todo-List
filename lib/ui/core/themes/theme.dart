import 'package:flutter/material.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';

class CustomTheme {
  CustomTheme._();

  static const String fontFamily = 'Outfit';

  static TextTheme text(BuildContext context) {
    return Theme.of(context).textTheme.copyWith(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
    );
  }

  static ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context) {
    return const ProgressIndicatorThemeData();
  }

  static AppBarTheme appBarTheme(BuildContext context) {
    return AppBarTheme(
      backgroundColor: ThemeColors.primary,
      elevation: 0,
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: ThemeColors.white),
      iconTheme: const IconThemeData(color: ThemeColors.white),
    );
  }

  static BottomSheetThemeData bottomSheetTheme(BuildContext context) {
    return BottomSheetThemeData(
      backgroundColor: ThemeColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }

  static FloatingActionButtonThemeData floatingActionButtonTheme(BuildContext context) {
    return FloatingActionButtonThemeData(backgroundColor: ThemeColors.primary, foregroundColor: ThemeColors.white);
  }
}
