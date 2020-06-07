import 'package:etherwallet/components/wallet/confirm_mnemonic.dart';
import 'package:etherwallet/context/wallet_setup_provider.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/wallet/display_mnemonic.dart';

class WalletCreatePage extends HookWidget {
  WalletCreatePage(this.title);

  final String title;

  Widget build(BuildContext context) {
    var store = useWalletSetup(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: store.state.step == WalletCreateSteps.display
          ? DisplayMnemonic(
              mnemonic: store.state.mnemonic,
              onNext: () async {
                store.goto(WalletCreateSteps.confirm);
              },
            )
          : ConfirmMnemonic(
              mnemonic: store.state.mnemonic,
              errors: store.state.errors.toList(),
              onConfirm: (confirmedMnemonic) async {
                if (await store.confirmMnemonic(confirmedMnemonic)) {
                  Navigator.of(context).popAndPushNamed("/");
                }
              },
              onGenerateNew: () async {
                store.generateMnemonic();
                store.goto(WalletCreateSteps.display);
              },
            ),
    );
  }
}
