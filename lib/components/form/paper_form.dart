import 'package:flutter/cupertino.dart';

class PaperForm extends StatelessWidget {
  const PaperForm(
      {Key? key, required this.children, this.padding = 8, this.actionButtons})
      : super(key: key);

  final List<Widget> children;
  final List<Widget>? actionButtons;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(children: [
            ...children,
            ..._buildButtons(),
          ]),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    if (actionButtons == null) {
      return List.empty();
    }

    return [
      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actionButtons!,
      )
    ];
  }
}
