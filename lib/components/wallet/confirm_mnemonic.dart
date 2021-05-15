import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ConfirmMnemonic extends HookWidget {
  const ConfirmMnemonic(
      {Key? key, this.errors, this.onConfirm, this.onGenerateNew})
      : super(key: key);

  final List<String>? errors;
  final Function(String)? onConfirm;
  final VoidCallback? onGenerateNew;

  @override
  Widget build(BuildContext context) {
    final mnemonicController = useTextEditingController();
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              OutlinedButton(
                child: const Text('Generate New'),
                onPressed: onGenerateNew,
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: onConfirm != null
                    ? () => onConfirm!(mnemonicController.value.text)
                    : null,
              )
            ],
            children: <Widget>[
              if (errors != null) PaperValidationSummary(errors!),
              PaperInput(
                labelText: 'Confirm your seed',
                hintText: 'Please type your seed phrase again',
                maxLines: 2,
                controller: mnemonicController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
