import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_list/core/services/dependency_injection_service.dart';
import 'package:todo_list/core/services/toast_provider.dart';
import 'package:todo_list/ui/core/themes/theme.dart';
import 'package:todo_list/ui/pages/home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  await injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Todo List',
        builder: ToastProvider.builder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: CustomTheme.fontFamily,
          useMaterial3: true,
          textTheme: CustomTheme.text(context),
          progressIndicatorTheme: CustomTheme.progressIndicatorTheme(context),
          appBarTheme: CustomTheme.appBarTheme(context),
          scaffoldBackgroundColor: Color(0xFFF4F4F5),
          bottomSheetTheme: CustomTheme.bottomSheetTheme(context),
          floatingActionButtonTheme: CustomTheme.floatingActionButtonTheme(context),
        ),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: HomePage(),
      ),
    );
  }
}
