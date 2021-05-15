import 'package:etherwallet/components/wallet/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'components/dialog/alert.dart';
import 'components/menu/main_menu.dart';
import 'context/wallet/wallet_provider.dart';
import 'package:flutter/services.dart';

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
        onReset: () => Alert(
            title: "Warning",
            text:
                "Without your seed phrase or private key you cannot restore your wallet balance",
            actions: [
              TextButton(
                child: Text("cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("reset"),
                onPressed: () async {
                  await store.resetWallet();
                  Navigator.popAndPushNamed(context, "/");
                },
              )
            ]).show(context),
        onRevealKey: () => Alert(
            title: "Private key",
            text: store.getPrivateKey() ?? "-",
            actions: [
              TextButton(
                child: Text("close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("copy and close"),
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
              icon: Icon(Icons.refresh),
              onPressed: !store.state.loading
                  ? () async {
                      await store.fetchOwnBalance();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Balance updated"),
                        duration: Duration(milliseconds: 800),
                      ));
                    }
                  : null,
            ),
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
