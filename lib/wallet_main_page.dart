import 'package:etherwallet/components/wallet/balance.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'components/menu/main_menu.dart';

class WalletMainPage extends StatefulWidget {
  WalletMainPage(this.walletStore, {Key key, this.title}) : super(key: key);

  final WalletStore walletStore;
  final String title;

  @override
  _WalletMainPageState createState() => _WalletMainPageState();
}

class _WalletMainPageState extends State<WalletMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainMenu(
          address: widget.walletStore.address,
          onReset: () async {
            await widget.walletStore.resetWallet();
            Navigator.popAndPushNamed(context, "/");
          },
        ),
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await widget.walletStore.fetchOwnBalance();
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
        body: Consumer<WalletStore>(
          builder: (context, walletStore, _) => Observer(
              builder: (_) => Balance(
                    address: walletStore.address,
                    ethBalance: walletStore.ethBalance,
                    tokenBalance: walletStore.tokenBalance,
                  )),
        ));
  }
}
