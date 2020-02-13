import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/stores/wallet_create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletCreatePage extends StatefulWidget {
  WalletCreatePage(
    this.store, {
    this.title,
  });

  final WalletCreateStore store;
  final String title;

  @override
  State<StatefulWidget> createState() => _WalletCreatePage();
}

class _WalletCreatePage extends State<WalletCreatePage> {
  @override
  void initState() {
    super.initState();
    widget.store.generateMnemonic();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (context) {
        return widget.store.step == WalletCreateSteps.display
            ? _displayMnemonic()
            : _confirmMnemonic();
      }),
    );
  }

  Widget _displayMnemonic() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Get a piece of papper, write down your seed phrase and keep it safe. This is the only way to recover your funds.",
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all()),
                child: Observer(
                  builder: (_) => Text(
                    widget.store.mnemonic,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CopyButton(
                    text: const Text('Copy'),
                    value: widget.store.mnemonic,
                  ),
                  RaisedButton(
                    child: const Text('Next'),
                    onPressed: () {
                      widget.store.goto(WalletCreateSteps.confirm);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmMnemonic() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              OutlineButton(
                child: const Text('Generate New'),
                onPressed: () async {
                  widget.store.generateMnemonic();
                },
              ),
              RaisedButton(
                child: const Text('Confirm'),
                onPressed: () async {
                  if (await widget.store.confirmMnemonic()) {
                    Navigator.of(context).popAndPushNamed("/");
                  }
                },
              )
            ],
            children: <Widget>[
              PaperValidationSummary(widget.store.errors),
              PaperInput(
                labelText: 'Confirm your seed',
                hintText: 'Please type your seed phrase again',
                maxLines: 2,
                onChanged: widget.store.setMnemonicConfirmation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
