import 'package:flutter/cupertino.dart';

class PaperValidationSummary extends StatelessWidget {
  PaperValidationSummary(this.errors);
  final List<String> errors;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.errors.map((error) => Text(error)).toList(),
    );
  }
}
