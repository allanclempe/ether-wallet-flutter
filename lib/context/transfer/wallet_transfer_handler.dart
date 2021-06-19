import 'dart:async';
import 'dart:math';

import 'package:etherwallet/context/transfer/wallet_transfer_state.dart';
import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/model/wallet_transfer.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/credentials.dart';

class WalletTransferHandler {
  WalletTransferHandler(
    this._store,
    this._contractServiceFactory,
    this._configurationService,
  );

  final Store<WalletTransfer, WalletTransferAction> _store;
  final ContractServiceFactory _contractServiceFactory;
  final ConfigurationService _configurationService;

  WalletTransfer get state => _store.state;

  Future<bool> transfer(NetworkType network, String to, String amount) async {
    final completer = Completer<bool>();
    final privateKey = _configurationService.getPrivateKey();

    _store.dispatch(WalletTransferStarted());

    final contractService = await _contractServiceFactory.getInstance(network);

    try {
      await contractService.send(
        privateKey!,
        EthereumAddress.fromHex(to),
        BigInt.from(double.parse(amount) * pow(10, 18)),
        onTransfer: (from, to, value) {
          completer.complete(true);
        },
        onError: (ex) {
          _store.dispatch(WalletTransferError(ex.toString()));
          completer.complete(false);
        },
      );
    } catch (ex) {
      _store.dispatch(WalletTransferError(ex.toString()));
      completer.complete(false);
    }

    return completer.future;
  }
}
