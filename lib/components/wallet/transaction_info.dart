import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/eth_address_formatter.dart';

class TransactionInfo extends HookWidget {
  const TransactionInfo(
      {super.key, required this.transactionId, required this.explorerUrl});

  final String transactionId;
  final String explorerUrl;

  @override
  Widget build(BuildContext context) {
    final url = useMemoized(() => Uri.parse('$explorerUrl/tx/$transactionId'),
        [explorerUrl, transactionId]);
    final theme = Theme.of(context);

    return InkWell(
        child: Text(
          'View transaction ${EthAddressFormatter(transactionId).mask()}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.apply(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () async {
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        });
  }
}
