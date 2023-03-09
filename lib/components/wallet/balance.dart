import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.balance,
    this.symbol = '',
    this.fontSizeDelta = 0,
    this.fontColor = Colors.black,
  }) : super(key: key);

  final BigInt? balance;
  final String? symbol;
  final double fontSizeDelta;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '${EthAmountFormatter(balance).format()} $symbol',
      style: theme.textTheme.bodyLarge?.apply(
        fontSizeDelta: fontSizeDelta,
        color: fontColor,
      ),
    );
  }
}
