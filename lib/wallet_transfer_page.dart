import 'package:etherwallet/components/wallet/transfer_form.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
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
    final qrcodeAddress = useState('');

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
          ? const Loading()
          : TransferForm(
              address: qrcodeAddress.value,
              onSubmit: (address, amount) async {
                final success = await transferStore.transfer(
                  network,
                  address,
                  amount,
                );

                if (success) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            ),
    );
  }
}
