import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef OnRadioChanged = void Function(
  dynamic value,
);

class PaperRadio extends StatelessWidget {
  const PaperRadio(
    this.title, {
    this.value,
    this.groupValue,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final dynamic value;
  final String title;
  final dynamic groupValue;
  final OnRadioChanged? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }
}
