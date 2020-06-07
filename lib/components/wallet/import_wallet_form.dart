import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_radio.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef ImportType = void Function(WalletImportType type, String value);

class ImportWalletForm extends HookWidget {
  ImportWalletForm({this.onImport, this.errors});

  final ImportType onImport;
  final List<String> errors;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var importType = useState(WalletImportType.mnemonic);

    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              RaisedButton(
                child: const Text('Import'),
                onPressed: () =>
                    this.onImport(importType.value, inputController.value.text),
              )
            ],
            children: <Widget>[
              Row(
                children: <Widget>[
                  PaperRadio(
                    "Seed",
                    groupValue: importType.value,
                    value: WalletImportType.mnemonic,
                    onChanged: (value) => importType.value = value,
                  ),
                  PaperRadio(
                    "Private Key",
                    groupValue: importType.value,
                    value: WalletImportType.privateKey,
                    onChanged: (value) => importType.value = value,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Visibility(
                      child: fieldForm(
                          label: 'Private Key',
                          hintText: 'Type your private key'),
                      visible: importType.value == WalletImportType.privateKey),
                  Visibility(
                      child: fieldForm(
                          label: 'Seed phrase',
                          hintText: 'Type your seed phrase'),
                      visible: importType.value == WalletImportType.mnemonic),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldForm({String label, String hintText}) {
    return Column(
      children: <Widget>[
        PaperValidationSummary(errors),
        PaperInput(
          labelText: label,
          hintText: hintText,
          maxLines: 3,
          controller: inputController,
        ),
      ],
    );
  }
}
