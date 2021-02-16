import 'dart:ui';

import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImportWalletForm extends HookWidget {
  ImportWalletForm({this.onImport, this.errors});

  final Function(WalletImportType type, String value) onImport;
  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    var importType = useState(WalletImportType.mnemonic);
    var inputController = useTextEditingController();

    final LinearGradient button_gradient =
        LinearGradient(colors: [Color(0xFF0779E4), Color(0xFF1DD3BD)]);

    final _selections = useState([true, false]);

    void changeSelections() {
      _selections.value[0] = !_selections.value[0];
      _selections.value[1] = !_selections.value[1];
    }

    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: PaperForm(
            actionButtons: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: button_gradient,
                      borderRadius: BorderRadius.circular(10)),
                  height: 55,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.transparent,
                    child: Text(
                      "IMPORT",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: this.onImport != null
                        ? () => this.onImport(
                            importType.value, inputController.value.text)
                        : null,
                  ),
                ),
              )
            ],
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleButtons(
                    fillColor: Colors.transparent,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'Seed',
                          style:TextStyle(
                            fontSize: 15,
                            color: Colors.transparent,
                            decoration: _selections.value[0] ? TextDecoration.underline: null,
                            decorationColor: Colors.white,
                            shadows: [
                              Shadow(color: Colors.white, offset: Offset(0, -5))
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Private Key',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.transparent,
                          decoration:_selections.value[1] ? TextDecoration.underline: null,
                          decorationColor: Colors.white,
                          shadows: [
                            Shadow(color: Colors.white, offset: Offset(0, -5))
                          ],
                        ),
                      )
                    ],
                    isSelected: _selections.value,
                    onPressed: (ind) => changeSelections(),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Text(
                      importType.value == WalletImportType.privateKey
                          ? 'Private Key'
                          : 'Seed Phrase',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
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

  final darkGrey = Color(0xFF1C1C1C);

  Widget fieldForm({
    String label,
    String hintText,
    TextEditingController controller,
  }) {
    return Column(
      children: <Widget>[
        PaperValidationSummary(errors),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: darkGrey,
          ),
          child: PaperInput(
            hintText: hintText,
            maxLines: 3,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
