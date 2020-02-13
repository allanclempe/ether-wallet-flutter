import 'package:etherwallet/components/wallet/balance.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Get tokens "),
              subtitle: Text("Receive some test tokens"),
              trailing: Icon(Icons.attach_money),
              onTap: () async {
                var url =
                    'http://ec2-54-213-50-23.us-west-2.compute.amazonaws.com/transfer?address=${widget.walletStore.address}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              title: Text("Reset wallet"),
              subtitle: Text(
                  "warning: without your seed phrase you cannot restore your wallet"),
              trailing: Icon(Icons.warning),
              onTap: () async {
                await widget.walletStore.resetWallet();
                Navigator.popAndPushNamed(context, "/");
              },
            ),
          ],
        ),
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
        builder: (context, walletStore, _) => Balance(walletStore),
      ),
    );
  }
}
