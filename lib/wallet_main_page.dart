import 'package:etherwallet/components/wallet/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/dialog/alert.dart';
import 'components/menu/main_menu.dart';
import 'context/wallet/wallet_provider.dart';
import 'model/network_type.dart';

class WalletMainPage extends HookWidget {
  const WalletMainPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final store = useWallet(context);

    useEffect(() {
      store.initialise(store.state.network);
      return null;
    }, [store.state.network]);

    return Scaffold(
      drawer: MainMenu(
        address: store.state.address,
        onReset: () => Alert(
            title: 'Warning',
            text:
                'Without your seed phrase or private key you cannot restore your wallet balance',
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
                  Clipboard.setData(ClipboardData(text: store.getPrivateKey()));
                  Navigator.of(context).pop();
                },
              ),
            ]).show(context),
      ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !store.state.loading
                  ? () async {
                      await store.fetchOwnBalance();
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
              Navigator.of(context).pushNamed('/transfer');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<NetworkType>(
            items: [
              NetworkType.ropsten,
              NetworkType.matic,
              NetworkType.bsc,
              NetworkType.local
            ]
                .map((NetworkType value) => DropdownMenuItem<NetworkType>(
                      value: value,
                      child: Text(value.toString()),
                    ))
                .toList(),
            onChanged: (value) {
              store.changeNetwork(value!);
            },
          ),
          Balance(
            address: store.state.address,
            ethBalance: store.state.ethBalance,
            tokenBalance: store.state.tokenBalance,
          )
        ],
      ),
    );
  }
}
