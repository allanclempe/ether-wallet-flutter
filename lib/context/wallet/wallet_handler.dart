import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/model/wallet.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_locator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/web3dart.dart' as web3;

import 'wallet_state.dart';

class WalletHandler {
  WalletHandler(
    this._store,
    this._addressService,
    this._contractLocator,
    this._configurationService,
  );

  final Store<Wallet, WalletAction> _store;
  final AddressService _addressService;
  final ConfigurationService _configurationService;
  final ContractLocator _contractLocator;

  Wallet get state => _store.state;

  Future<void> initialise() async {
    final entropyMnemonic = _configurationService.getMnemonic();
    final privateKey = _configurationService.getPrivateKey();

    if (entropyMnemonic != null && entropyMnemonic.isNotEmpty) {
      _initialiseFromMnemonic(state.network, entropyMnemonic);
      return;
    }
    if (privateKey != null && privateKey.isNotEmpty) {
      _initialiseFromPrivateKey(state.network, privateKey);
      return;
    }

    throw Exception('Wallet could not be initialised.');
  }

  Future<void> _initialiseFromMnemonic(
      NetworkType network, String entropyMnemonic) async {
    final mnemonic = _addressService.entropyToMnemonic(entropyMnemonic);
    final privateKey = await _addressService.getPrivateKey(mnemonic);
    final address = await _addressService.getPublicAddress(privateKey);

    _store.dispatch(InitialiseWallet(network, address.toString(), privateKey));

    await refreshBalance();
  }

  Future<void> _initialiseFromPrivateKey(
      NetworkType network, String privateKey) async {
    final address = await _addressService.getPublicAddress(privateKey);

    _store.dispatch(InitialiseWallet(network, address.toString(), privateKey));

    await refreshBalance();
  }

  Function()? listenTransfers(String? address, NetworkType network) {
    if (address == null || address.isEmpty) {
      return null;
    }

    final subscription = _contractLocator
        .getInstance(network)
        .listenTransfer((from, to, value) async {
      final fromMe = from.toString() == address;
      final toMe = to.toString() == address;

      if (!fromMe && !toMe) {
        return;
      }

      print('======= balance updated =======');

      await refreshBalance();
    });

    return subscription.cancel;
  }

  Future<void> changeNetwork(NetworkType network) async {
    _store.dispatch(NetworkChanged(network));

    await refreshBalance();
  }

  Future<void> refreshBalance() async {
    if (state.address?.isEmpty ?? true) {
      return;
    }

    final contractService = _contractLocator.getInstance(state.network);

    _store.dispatch(UpdatingBalance());

    final tokenBalance = await contractService
        .getTokenBalance(web3.EthereumAddress.fromHex(state.address!));

    final ethBalance = await contractService
        .getEthBalance(web3.EthereumAddress.fromHex(state.address!));

    _store.dispatch(BalanceUpdated(ethBalance.getInWei, tokenBalance));
  }

  Future<void> resetWallet() async {
    await _configurationService.setMnemonic(null);
    await _configurationService.setupDone(false);
  }

  String? getPrivateKey() {
    return _configurationService.getPrivateKey();
  }
}
