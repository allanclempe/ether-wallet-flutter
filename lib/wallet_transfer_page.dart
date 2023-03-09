import 'package:etherwallet/components/wallet/transaction_info.dart';
import 'package:etherwallet/components/wallet/transfer_form.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/model/network_type.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/wallet/loading.dart';

class WalletTransferPage extends HookWidget {
  const WalletTransferPage({
    Key? key,
    required this.title,
    required this.network,
  }) : super(key: key);

  final String title;
  final NetworkType network;

  @override
  Widget build(BuildContext context) {
    final transferStore = useWalletTransfer(context);
    final walletStore = useWallet(context);
    final qrcodeAddress = useState('');
    final transactionId = transferStore.state.transactionId;
    final network = walletStore.state.network;

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (!kIsWeb)
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: !transferStore.state.loading
                  ? () {
                      Navigator.of(context).pushNamed(
                        '/qrcode_reader',
                        arguments: (scannedAddress) {
                          qrcodeAddress.value = scannedAddress.toString();
                        },
                      );
                    }
                  : null,
            ),
        ],
      ),
      body: transferStore.state.loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Loading(),
                  if (transactionId != null)
                    TransactionInfo(
                        transactionId: transactionId,
                        explorerUrl: network.config.explorerUrl)
                ],
              ),
            )
          : TransferForm(
              address: qrcodeAddress.value,
              onSubmit: (type, address, amount) async {
                final success = await transferStore.transfer(
                  network,
                  type,
                  address,
                  amount,
                );

                if (success) {
                  walletStore.refreshBalance();

                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            ),
    );
  }
}
