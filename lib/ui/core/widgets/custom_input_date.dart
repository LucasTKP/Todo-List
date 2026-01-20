import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';

class InputDate extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final bool enabled;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;
  final String? value;
  final String? initialValue;
  final IconData? prefixIcon;
  final String? Function(String?) validator;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(String) onChanged;
  final DateTime? dataSelecionada;

  const InputDate({
    super.key,
    this.labelText,
    required this.hintText,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    this.backgroundColor = Colors.white,
    this.value,
    this.initialValue,
    this.prefixIcon,
    required this.validator,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    required this.dataSelecionada,
  });

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? widget.initialValue);
  }

  @override
  void didUpdateWidget(InputDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      style: TextStyle(
        color: widget.enabled ? ThemeColors.secondary : Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIconColor: widget.enabled ? ThemeColors.secondary : Colors.grey,
        contentPadding: widget.contentPadding,
        fillColor: widget.backgroundColor,
        filled: true,
        alignLabelWithHint: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.enabled ? ThemeColors.secondary : Colors.grey),
        labelText: widget.value != null ? widget.labelText : null,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: widget.enabled ? ThemeColors.secondary : Colors.grey) : null,
        labelStyle: TextStyle(color: widget.enabled ? ThemeColors.secondary : Colors.grey),
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
      readOnly: true,
      onTap: () async {
        if (widget.enabled == false) return;
        final DateTime? date = await showCupertinoModalPopup<DateTime>(
          context: context,
          builder: (BuildContext context) {
            int selectedDay = widget.dataSelecionada?.day ?? DateTime.now().day;
            int selectedMonth = widget.dataSelecionada?.month ?? DateTime.now().month;
            int selectedYear = widget.dataSelecionada?.year ?? DateTime.now().year;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                int daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;

                if (selectedDay > daysInMonth) {
                  selectedDay = daysInMonth;
                }

                return Container(
                  height: 300,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Text('Cancelar', style: TextStyle(color: ThemeColors.secondary)),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoButton(
                            child: const Text('OK', style: TextStyle(color: ThemeColors.secondary)),
                            onPressed: () {
                              final date = DateTime(selectedYear, selectedMonth, selectedDay);
                              Navigator.pop(context, date);
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // Dia
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: selectedDay - 1,
                                ),
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedDay = index + 1;
                                  });
                                },
                                children: List<Widget>.generate(daysInMonth, (int index) {
                                  return Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // Mês
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: selectedMonth - 1,
                                ),
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedMonth = index + 1;
                                  });
                                },
                                children: List<Widget>.generate(12, (int index) {
                                  return Center(
                                    child: Text(
                                      DateFormat.MMMM('pt_BR').format(DateTime(2000, index + 1)),
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // Ano
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: selectedYear - widget.firstDate.year,
                                ),
                                itemExtent: 32.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedYear = widget.firstDate.year + index;
                                  });
                                },
                                children: List<Widget>.generate(
                                  widget.lastDate.year - widget.firstDate.year + 1,
                                  (int index) {
                                    return Center(
                                      child: Text(
                                        '${widget.firstDate.year + index}',
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );

        if (date != null) {
          final formattedDate = DateFormat('dd/MM/yyyy').format(date);
          _controller.text = formattedDate;
          widget.onChanged(formattedDate);
        }
      },
    );
  }
}
