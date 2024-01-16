import 'package:etherwallet/components/wallet/balance.dart';
import 'package:etherwallet/components/wallet/copyable_address.dart';
import 'package:etherwallet/utils/eth_address_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/dialog/alert.dart';
import 'components/menu/main_menu.dart';
import 'components/wallet/change_network.dart';
import 'context/wallet/wallet_provider.dart';

class WalletMainPage extends HookWidget {
  const WalletMainPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final store = useWallet(context);
    final address = store.state.address;
    final network = store.state.network;

    useEffect(() {
      store.initialize();

      return null;
    }, []);

    useEffect(
      () => store.listenTransfers(address, network),
      [address, network],
    );

    return Scaffold(
      drawer: MainMenu(
        network: network,
        address: address,
        onReset: () => Alert(
            title: 'Warning',
            text:
                'Without your seed phrase or private key you cannot restore your wallet balance.',
            actions: [
              TextButton(
                child: const Text('cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('reset'),
                onPressed: () async {
                  await store.resetWallet();
                  Navigator.popAndPushNamed(context, '/');
                },
              )
            ]).show(context),
        onRevealKey: () => Alert(
            title: 'Private key',
            text:
                'WARNING: In production environment the private key should be protected with password.\r\n\r\n${store.getPrivateKey() ?? "-"}',
            actions: [
              TextButton(
                child: const Text('close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('copy and close'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                    text: store.getPrivateKey()!,
                  ));
                  Navigator.of(context).pop();
                },
              ),
            ]).show(context),
        onGenerateSSS: () {
          final secrets = store.generateSSS(3, 5);
          final v = secrets.asMap().entries.map((item) =>
              '${item.key + 1}: ${EthAddressFormatter(item.value).mask()}');

          Alert(
              title: "Shamir's Secret Sharing",
              text:
                  'WARNING: 3 parts of the 5 generated can be used to reveal your private key.\r\n\r\n${v.join('\r\n')}',
              actions: [
                TextButton(
                  child: const Text('close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('copy and close'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                      text: secrets.join('\r\n'),
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ]).show(context);
        },
      ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !store.state.loading
                  ? () async {
                      await store.refreshBalance();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Balance updated'),
                        duration: Duration(milliseconds: 800),
                      ));
                    }
                  : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/transfer', arguments: store.state.network);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChangeNetwork(
              onChange: store.changeNetwork,
              currentValue: store.state.network,
              loading: store.state.loading,
            ),
            const SizedBox(height: 10),
            CopyableAddress(address: store.state.address),
            Balance(
              balance: store.state.tokenBalance,
              symbol: 'tokens',
              fontSizeDelta: 6,
            ),
            Balance(
              balance: store.state.ethBalance,
              symbol: network.config.symbol,
              fontColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
