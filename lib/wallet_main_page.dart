import 'package:etherwallet/components/wallet/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'components/dialog/alert.dart';
import 'components/menu/main_menu.dart';
import 'context/wallet/wallet_provider.dart';

class WalletMainPage extends HookWidget {
  WalletMainPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    var store = useWallet(context);

    useEffect(() {
      store.initialise();
      return null;
    }, []);

    return Scaffold(
      drawer: MainMenu(
        address: store.state.address,
        onReset: () async {
          Alert(
              title: "Warning",
              text:
                  "Without your seed phrase you cannot restore your wallet balance",
              actions: [
                FlatButton(
                  child: Text("cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("reset"),
                  onPressed: () async {
                    await store.resetWallet();
                    Navigator.popAndPushNamed(context, "/");
                  },
                )
              ]).show(context);
        },
      ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await store.fetchOwnBalance();
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              Navigator.of(context).pushNamed("/transfer");
            },
          ),
        ],
      ),
      body: Balance(
        address: store.state.address,
        ethBalance: store.state.ethBalance,
        tokenBalance: store.state.tokenBalance,
      ),
    );
  }
}
