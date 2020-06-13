import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatelessWidget {
  MainMenu({this.address, this.onReset});

  final String address;
  final Function onReset;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Get tokens"),
            subtitle: Text("Receive some test tokens"),
            trailing: Icon(WalletIcons.gem, color: Colors.blue),
            onTap: () async {
              var url = 'https://faucet.clempe.dev?address=${this.address}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            title: Text("Get ETH"),
            subtitle: Text("Receive some test ether"),
            trailing: Icon(
              WalletIcons.ethereum,
              color: Colors.black,
            ),
            onTap: () async {
              var url = 'https://faucet.ropsten.be';
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
              trailing: Icon(
                WalletIcons.skull,
                color: Colors.orange,
              ),
              onTap: this.onReset),
        ],
      ),
    );
  }
}
