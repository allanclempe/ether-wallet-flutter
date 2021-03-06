import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  CopyButton({this.text, this.value});
  final Text text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: this.text,
      onPressed: () {
        Clipboard.setData(ClipboardData(text: this.value));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Copied"),
        ));
      },
    );
  }
}
