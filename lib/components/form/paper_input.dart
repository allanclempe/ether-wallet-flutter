import 'dart:ui';

import 'package:flutter/material.dart';

class PaperInput extends StatelessWidget {
  PaperInput(
      {this.labelText,
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

  final Color borderColor = Color(0xFF282828);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Color(0xFF282828)),
  );
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.obscureText,
      controller: this.controller,
      onChanged: this.onChanged,
      maxLines: this.maxLines,
      decoration: InputDecoration(
        border: border,
        focusedBorder: border,
        disabledBorder: border,
        enabledBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        labelText: this.labelText,
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        hintText: this.hintText,
        errorText: this.errorText,
      ),
    );
  }
}
