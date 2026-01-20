import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';

class CustomInputs {
  static Widget standard({
    TextEditingController? controller,
    required String label,
    required int? maxLength,
    required TextInputType keyboardType,
    bool buildCounter = false,
    bool obscureText = false,
    String? Function(String?)? validator,
    IconData? prefixIcon,
    double prefixIconSize = 24,
    String? prefixText,
    Widget? suffixIcon,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? hintText,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    int maxLines = 1,
    Function(String)? onChanged,
    BoxConstraints? constraints,
    double fontSize = 16,
    String? initialValue,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLength: maxLength,
      buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) => buildCounter ? Text('$currentLength/$maxLength', style: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey)) : null,
      style: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey, fontWeight: FontWeight.w500, fontSize: fontSize),
      maxLines: maxLines,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        constraints: constraints,
        prefixText: prefixText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: enabled ? ThemeColors.secondary : Colors.grey, size: prefixIconSize) : null,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        labelText: label,
        floatingLabelStyle: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey, fontSize: 16),
        hintText: hintText,
        hintStyle: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey, fontSize: fontSize),
        filled: true,
        contentPadding: contentPadding,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: enabled ? ThemeColors.secondary : Colors.grey,
          fontSize: fontSize,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.secondary),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.secondary, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.secondary),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
