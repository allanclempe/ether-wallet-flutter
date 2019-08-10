import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/model/transaction.dart';
import 'package:etherwallet/stores/wallet_transfer_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WalletTransferPage extends StatefulWidget {
  WalletTransferPage(this.store, {Key key, this.title}) : super(key: key);

  final WalletTransferStore store;
  final String title;

  @override
  _WalletTransferPageState createState() => _WalletTransferPageState();
}

class _WalletTransferPageState extends State<WalletTransferPage> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.store.reset();
    _popForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.of(context).pushNamed("/qrcode_reader",
                  arguments: (ethAddress) async {
                widget.store.setTo(ethAddress);
                _popForm();
              });
            },
          ),
        ],
      ),
      body: buildForm(),
    );
  }

  Widget buildForm() {
    return SingleChildScrollView(
      child: Observer(
        builder: (_) {
          return PaperForm(
            padding: 50,
            children: <Widget>[
              PaperValidationSummary(widget.store.errors),
              PaperInput(
                controller: _toController,
                labelText: 'To',
                hintText: 'Type the destination address',
                onChanged: widget.store.setTo,
              ),
              PaperInput(
                controller: _amountController,
                labelText: 'Amount',
                hintText: 'And amount',
                onChanged: widget.store.setAmount,
              ),
              RaisedButton(
                child: const Text('Transfer now'),
                onPressed: !widget.store.loading
                    ? () {
                        widget.store.transfer().listen((tx) {
                          switch (tx.status) {
                            case TransactionStatus.started:
                              Navigator.pushNamed(
                                  context, '/processing-transaction');
                              break;
                            case TransactionStatus.confirmed:
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                              break;
                          }
                        }).onError(
                            (error) => widget.store.setError(error.message));
                      }
                    : null,
              )
            ],
          );
        },
      ),
    );
  }

  void _popForm() {
    _toController.value = TextEditingValue(text: widget.store.to ?? "");
    _amountController.value = TextEditingValue(text: widget.store.amount ?? "");
  }

  @override
  void dispose() {
    _toController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
