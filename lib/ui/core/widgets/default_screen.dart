import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  final String titleAppBar;
  final Widget body;
  final Widget? floatingActionButton;
  const DefaultScreen({
    super.key,
    required this.titleAppBar,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleAppBar)),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
