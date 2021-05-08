import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_radio.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImportWalletForm extends HookWidget {
  ImportWalletForm({this.onImport, this.errors});

  final Function(WalletImportType type, String value)? onImport;
  final List<String>? errors;

  @override
  Widget build(BuildContext context) {
    var importType = useState(WalletImportType.mnemonic);
    var inputController = useTextEditingController();

    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              ElevatedButton(
                child: const Text('Import'),
                onPressed: this.onImport != null
                    ? () => this.onImport!(
                        importType.value, inputController.value.text)
                    : null,
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
                          hintText: 'Type your private key',
                          controller: inputController),
                      visible: importType.value == WalletImportType.privateKey),
                  Visibility(
                      child: fieldForm(
                          label: 'Seed phrase',
                          hintText: 'Type your seed phrase',
                          controller: inputController),
                      visible: importType.value == WalletImportType.mnemonic),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldForm({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      children: <Widget>[
        if (errors != null) PaperValidationSummary(errors!),
        PaperInput(
          labelText: label,
          hintText: hintText,
          maxLines: 3,
          controller: controller,
        ),
      ],
    );
  }
}
