import 'package:flutter/material.dart';
import 'package:todo_list/ui/core/themes/extensions.dart';
import 'package:todo_list/ui/core/themes/theme_colors.dart';
import 'package:todo_list/ui/core/widgets/default_button.dart';

class GenericErrorScreen extends StatelessWidget {
  final VoidCallback tryAgain;
  const GenericErrorScreen({super.key, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: ThemeColors.white, size: 80),
        SizedBox(height: 16),
        Text('Algo deu errado', style: context.textTheme.titleMedium, textAlign: TextAlign.center),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Feche o aplicativo e abra novamente, se o erro\npersistir entre em contato com o suporte. ',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 32),
        DefaultButton.standard(
          onPressed: tryAgain,
          label: "Tentar novamente",
          buttonIsLoading: false,
        ),
      ],
    );
  }
}
