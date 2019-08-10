import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_radio.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/stores/wallet_import_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletImportPage extends StatefulWidget {
  WalletImportPage(
    this.store, {
    this.title,
  });

  final WalletImportStore store;
  final String title;

  @override
  State<StatefulWidget> createState() => _WalletImportPage();
}

class _WalletImportPage extends State<WalletImportPage> {
  @override
  void initState() {
    super.initState();
    widget.store.reset();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (_) => buildForm()),
    );
  }

  Widget buildForm() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              RaisedButton(
                child: const Text('Import'),
                onPressed: () async {
                  if (widget.store.type == WalletImportType.mnemonic &&
                      await widget.store.confirmMnemonic()) {
                    Navigator.of(context).popAndPushNamed("/");
                  }

                  if (widget.store.type == WalletImportType.privateKey &&
                      await widget.store.confirmPrivateKey()) {
                    Navigator.of(context).popAndPushNamed("/");
                  }
                },
              )
            ],
            children: <Widget>[
              Row(
                children: <Widget>[
                  PaperRadio(
                    "Mnemonic",
                    groupValue: widget.store.type,
                    value: WalletImportType.mnemonic,
                    onChanged: (value) => widget.store.setType(value),
                  ),
                  PaperRadio(
                    "Private Key",
                    groupValue: widget.store.type,
                    value: WalletImportType.privateKey,
                    onChanged: (value) => widget.store.setType(value),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Visibility(
                      child: privateKeyForm(),
                      visible:
                          widget.store.type == WalletImportType.privateKey),
                  Visibility(
                      child: mnemonicForm(),
                      visible: widget.store.type == WalletImportType.mnemonic),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget privateKeyForm() {
    return Column(
      children: <Widget>[
        PaperValidationSummary(widget.store.errors),
        PaperInput(
          labelText: 'Private Key',
          hintText: 'Type your private key',
          maxLines: 3,
          onChanged: widget.store.setPrivateKey,
        ),
      ],
    );
  }

  Widget mnemonicForm() {
    return Column(
      children: <Widget>[
        Observer(
          builder: (context) => PaperValidationSummary(widget.store.errors),
        ),
        PaperInput(
          labelText: 'Mnemonic',
          hintText: 'Type mnemonic',
          maxLines: 3,
          onChanged: widget.store.setMnemonic,
        ),
      ],
    );
  }
}
