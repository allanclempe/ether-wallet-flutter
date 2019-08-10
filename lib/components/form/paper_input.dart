import 'package:flutter/material.dart';

class PaperInput extends StatelessWidget {
  PaperInput({
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.controller,
    this.maxLines,
    this.obscureText = false,
  });

  final ValueChanged<String> onChanged;
  final String errorText;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.obscureText,
      controller: this.controller,
      onChanged: this.onChanged,
      maxLines: this.maxLines,
      decoration: InputDecoration(
        labelText: this.labelText,
        hintText: this.hintText,
        errorText: this.errorText,
      ),
    );
  }
}
