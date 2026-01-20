import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';

class CustomCircularProgress extends StatelessWidget {
  final Color color;
  final double? size;

  const CustomCircularProgress({
    super.key,
    this.size,
    this.color = ThemeColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeCircular = size ?? math.min(width * 0.1, 120).toDouble();
    final strokeCircular = sizeCircular * 0.1;

    return SizedBox(
      width: sizeCircular,
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(color: color, strokeWidth: strokeCircular),
      ),
    );
  }
}
