import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TransferForm extends HookWidget {
  TransferForm({
    this.address,
    @required this.onSubmit,
  });

  final String address;
  final void Function(String address, String amount) onSubmit;

  @override
  Widget build(BuildContext context) {
    final toController = useTextEditingController(text: address);
    final amountController = useTextEditingController();
    final transferStore = useWalletTransfer(context);

    useEffect(() {
      if (address != null) toController.value = TextEditingValue(text: address);
      return null;
    }, [address]);

    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              ElevatedButton(
                child: const Text('Transfer now'),
                onPressed: () {
                  this.onSubmit(
                    toController.value.text,
                    amountController.value.text,
                  );
                },
              )
            ],
            children: <Widget>[
              PaperValidationSummary(transferStore.state.errors.toList()),
              PaperInput(
                controller: toController,
                labelText: 'To',
                hintText: 'Type the destination address',
              ),
              PaperInput(
                controller: amountController,
                labelText: 'Amount',
                hintText: 'And amount',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
