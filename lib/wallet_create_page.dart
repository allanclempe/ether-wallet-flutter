import 'package:etherwallet/components/wallet/confirm_mnemonic.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/state/use_create_wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/wallet/display_mnemonic.dart';

class WalletCreatePage extends HookWidget {
  WalletCreatePage(this.addressService, {this.title});

  final IAddressService addressService;
  final String title;

  Widget build(BuildContext context) {
    var state = useCreateWalletState(context, addressService);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: state.isDisplayStep
          ? DisplayMnemonic(
              mnemonic: state.mnemonic.value,
              onNext: () async {
                state.goConfirm();
              },
            )
          : ConfirmMnemonic(
              mnemonic: state.mnemonic.value,
              errors: state.errors.value,
              onConfirm: (confirmedMnemonic) async {
                if (await state.confirmMnemonic(confirmedMnemonic)) {
                  Navigator.of(context).popAndPushNamed("/");
                }
              },
              onGenerateNew: () async {
                state.generateMnemonic();
                state.goDisplay();
              },
            ),
    );
  }
}
