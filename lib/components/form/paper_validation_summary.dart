import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PaperValidationSummary extends StatelessWidget {
  PaperValidationSummary(this.errors);
  final List<String> errors;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        child: Column(
          children: this.errors.map((error) => Text(error)).toList(),
        ),
      ),
    );
  }
}
