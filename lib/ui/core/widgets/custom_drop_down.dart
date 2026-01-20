import 'package:flutter/material.dart';
import 'package:todo_list/core/services/toast_provider.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final String labelText;
  final String hintText;
  final T? value;
  final EdgeInsetsGeometry contentPadding;
  final T? initialValue;
  final bool enabled;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final Color? backgroundColor;
  final String messageOnTapIsEmpty;
  final bool alignLabelWithHint;
  final double fontSize;

  CustomDropDown({
    super.key,
    required this.items,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.prefixIconColor = ThemeColors.secondary,
    this.value,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.backgroundColor = Colors.white,
    this.messageOnTapIsEmpty = 'Nenhum item disponível',
    this.alignLabelWithHint = true,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (items.isEmpty) {
          toast.showInfo(
            messageOnTapIsEmpty,
            alignment: Alignment.topRight,
          );
        }
      },
      child: AbsorbPointer(
        absorbing: items.isEmpty,
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            dropdownColor: Colors.white,
            value: value,
            borderRadius: BorderRadius.circular(8),
            menuMaxHeight: 300,
            onChanged: enabled ? onChanged : null,
            alignment: Alignment.centerLeft,
            hint: Text(hintText, style: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey)),
            items: items,
            validator: validator,
            isExpanded: true,
            decoration: InputDecoration(
              prefixIconColor: enabled ? prefixIconColor : Colors.grey,
              contentPadding: contentPadding,
              fillColor: backgroundColor,
              filled: true,
              alignLabelWithHint: alignLabelWithHint,
              labelText: labelText,
              labelStyle: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey),
              hintStyle: TextStyle(color: enabled ? ThemeColors.secondary : Colors.grey),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: enabled ? ThemeColors.secondary : Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ThemeColors.secondary, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: enabled ? ThemeColors.secondary : Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: Icon(Icons.arrow_drop_down, color: enabled ? ThemeColors.secondary : Colors.grey),
          ),
        ),
      ),
    );
  }
}
