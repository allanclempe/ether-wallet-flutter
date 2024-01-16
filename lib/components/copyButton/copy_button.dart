import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final Text text;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: text,
      onPressed: value != null
          ? () {
              Clipboard.setData(ClipboardData(text: value!));
            }
          : null,
    );
  }
}
