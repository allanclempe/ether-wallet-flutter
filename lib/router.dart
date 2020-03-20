import 'package:etherwallet/processing_transaction_page.dart';
import 'package:etherwallet/qrcode_reader_page.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:etherwallet/stores/wallet_transfer_store.dart';
import 'package:etherwallet/wallet_create_page.dart';
import 'package:etherwallet/wallet_import_page.dart';
import 'package:etherwallet/wallet_main_page.dart';
import 'package:etherwallet/wallet_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) => Consumer<ConfigurationService>(
            builder: (context, configurationService, _) {
          if (configurationService.didSetupWallet())
            return Consumer<WalletStore>(
              builder: (context, walletStore, _) =>
                  WalletMainPage(walletStore, title: "Your wallet"),
            );

          return IntroPage();
        }),
    '/create': (BuildContext context) => WalletCreatePage("Create wallet"),
    '/import': (BuildContext context) => WalletImportPage("Import wallet"),
    '/transfer': (BuildContext context) => Consumer<WalletTransferStore>(
          builder: (context, walletTransferStore, _) =>
              WalletTransferPage(walletTransferStore, title: "Send Tokens"),
        ),
    '/processing-transaction': (BuildContext context) =>
        Consumer<WalletTransferStore>(
          builder: (context, walletTransferStore, _) =>
              ProcessingTransactionPage(title: "Sending Tokens"),
        ),
    '/qrcode_reader': (BuildContext context) => QRCodeReaderPage(
          title: "Scan QRCode",
          onScanned: ModalRoute.of(context).settings.arguments,
        )
  };
}
