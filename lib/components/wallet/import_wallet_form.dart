import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_radio.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImportWalletForm extends HookWidget {
  const ImportWalletForm({Key? key, this.onImport, this.errors})
      : super(key: key);

  final Function(WalletImportType type, String value)? onImport;
  final List<String>? errors;

  @override
  Widget build(BuildContext context) {
    final importType = useState(WalletImportType.mnemonic);
    final inputController = useTextEditingController();

    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              ElevatedButton(
                child: const Text('Import'),
                onPressed: onImport != null
                    ? () =>
                        onImport!(importType.value, inputController.value.text)
                    : null,
              )
            ],
            children: <Widget>[
              Row(
                children: <Widget>[
                  PaperRadio(
                    'Seed',
                    groupValue: importType.value,
                    value: WalletImportType.mnemonic,
                    onChanged: (value) =>
                        importType.value = value as WalletImportType,
                  ),
                  PaperRadio(
                    'Private Key',
                    groupValue: importType.value,
                    value: WalletImportType.privateKey,
                    onChanged: (value) =>
                        importType.value = value as WalletImportType,
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
