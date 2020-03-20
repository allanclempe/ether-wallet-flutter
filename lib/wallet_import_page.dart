import 'package:etherwallet/components/wallet/import_wallet_form.dart';
import 'package:etherwallet/state/use_import_state.dart';
import 'package:etherwallet/stores/wallet_import_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WalletImportPage extends HookWidget {
  WalletImportPage(this.title);

  final String title;

  Widget build(BuildContext context) {
    var state = useImportWalletState(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ImportWalletForm(
        errors: state.errors.value,
        onImport: (type, value) async {
          switch (type) {
            case WalletImportType.mnemonic:
              if (!await state.confirmMnemonic(value)) return;
              break;
            case WalletImportType.privateKey:
              if (!await state.confirmPrivateKey(value)) return;
              break;
            default:
              break;
          }

          Navigator.of(context).popAndPushNamed("/");
        },
      ),
    );
  }
}
