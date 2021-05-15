import 'package:flutter/material.dart';

class Alert {
  Alert({required this.title, required this.text, this.actions});

  final String title;
  final String text;
  final List<Widget>? actions;

  void show(BuildContext context) {
    final alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: actions,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
