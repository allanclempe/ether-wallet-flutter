import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ConfirmMnemonic extends HookWidget {
  ConfirmMnemonic(
      {this.mnemonic, this.errors, this.onConfirm, this.onGenerateNew});

  final String mnemonic;
  final List<String> errors;
  final Function onConfirm;
  final Function onGenerateNew;

  @override
  Widget build(BuildContext context) {
    var mnemonicController = useTextEditingController();
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              OutlinedButton(
                child: const Text('Generate New'),
                onPressed: this.onGenerateNew,
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: this.onConfirm != null
                    ? () => this.onConfirm(mnemonicController.value.text)
                    : null,
              )
            ],
            children: <Widget>[
              PaperValidationSummary(this.errors),
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
