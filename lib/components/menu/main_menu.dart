import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
    required this.address,
    required this.onReset,
    required this.onRevealKey,
  }) : super(key: key);

  final String? address;
  final GestureTapCallback? onReset;
  final GestureTapCallback? onRevealKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Get tokens'),
            subtitle: const Text('Claim some test tokens'),
            trailing: const Icon(WalletIcons.gem, color: Colors.blue),
            onTap: () async {
              var url = 'https://faucet.clempe.dev?address=$address';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            title: const Text('Get ETH'),
            subtitle: const Text('Claim some test ether'),
            trailing: const Icon(
              WalletIcons.ethereum,
              color: Colors.black,
            ),
            onTap: () async {
              const url = 'https://faucet.ropsten.be';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
              title: const Text('Private key'),
              subtitle: const Text('Reveal your private key'),
              trailing: const Icon(
                WalletIcons.key,
                color: Colors.black,
              ),
              onTap: onRevealKey),
          ListTile(
              title: const Text('Reset wallet'),
              subtitle: const Text('Wipe all wallet data'),
              trailing: const Icon(
                WalletIcons.skull,
                color: Colors.orange,
              ),
              onTap: onReset),
        ],
      ),
    );
  }
}
