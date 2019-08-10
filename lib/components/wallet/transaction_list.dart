import 'package:etherwallet/stores/wallet_store.dart';
import 'package:etherwallet/utils/eth_address_formatter.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.store);
  final WalletStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ListView(
        children: store.transactions.map((transaction) {
          return ListTile(
            title: Text(EthAddressFormatter(transaction.to).mask()),
            trailing: Text(EthAmountFormatter(transaction.value).format()),
            subtitle:
                Text(DateFormat.yMMMMd().add_jm().format(transaction.date)),
          );
        }).toList(),
      );
    });
  }
}
