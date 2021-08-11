import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.address,
    required this.ethBalance,
    required this.tokenBalance,
    required this.symbol,
  }) : super(key: key);

  final String? address;
  final BigInt? ethBalance;
  final BigInt? tokenBalance;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(address ?? ''),
          const SizedBox(height: 10),
          CopyButton(
            text: const Text('Copy address'),
            value: address,
          ),
          if (address != null &&
              (mediaQuery.orientation == Orientation.portrait || kIsWeb))
            QrImage(
              data: address!,
              size: 150.0,
            ),
          Text(
            '${EthAmountFormatter(tokenBalance).format()} tokens',
            style:
                Theme.of(context).textTheme.bodyText2?.apply(fontSizeDelta: 6),
          ),
          Text(
            '${EthAmountFormatter(ethBalance).format()} $symbol',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.apply(color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
