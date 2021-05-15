import 'package:etherwallet/components/wallet/import_wallet_form.dart';
import 'package:etherwallet/context/setup/wallet_setup_provider.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WalletImportPage extends HookWidget {
  const WalletImportPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final store = useWalletSetup(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ImportWalletForm(
        errors: store.state.errors?.toList(),
        onImport: !store.state.loading
            ? (type, value) async {
                switch (type) {
                  case WalletImportType.mnemonic:
                    if (!await store.importFromMnemonic(value)) {
                      return;
                    }
                    break;
                  case WalletImportType.privateKey:
                    if (!await store.importFromPrivateKey(value)) {
                      return;
                    }
                    break;
                  default:
                    break;
                }

                Navigator.of(context).popAndPushNamed('/');
              }
            : null,
      ),
    );
  }
}
