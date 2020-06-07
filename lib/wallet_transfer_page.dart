import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/context/wallet_transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/wallet/loading.dart';

class WalletTransferPage extends HookWidget {
  WalletTransferPage({@required this.title});

  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final String title;

  @override
  Widget build(BuildContext context) {
    var transferStore = useWalletTransfer(context);
    useEffect(() {
      return () {
        _toController.dispose();
        _amountController.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: !transferStore.state.loading
                ? () {
                    Navigator.of(context).pushNamed(
                      "/qrcode_reader",
                      arguments: (ethAddress) async {
                        _toController.value =
                            TextEditingValue(text: ethAddress.toString());
                      },
                    );
                  }
                : null,
          ),
        ],
      ),
      body: transferStore.state.loading ? Loading() : buildForm(context),
    );
  }

  Widget buildForm(BuildContext context) {
    var transferStore = useWalletTransfer(context);

    return SingleChildScrollView(
        child: PaperForm(
      padding: 50,
      children: <Widget>[
        PaperValidationSummary(transferStore.state.errors.toList()),
        PaperInput(
          controller: _toController,
          labelText: 'To',
          hintText: 'Type the destination address',
        ),
        PaperInput(
          controller: _amountController,
          labelText: 'Amount',
          hintText: 'And amount',
        ),
        RaisedButton(
          child: const Text('Transfer now'),
          onPressed: () async {
            var success = await transferStore.transfer(
                _toController.value.text, _amountController.value.text);

            if (success) {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            }
          },
        )
      ],
    ));
  }
}
