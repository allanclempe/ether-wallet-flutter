import 'package:etherwallet/model/wallet.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/web3dart.dart' as web3;

import 'wallet_state.dart';

class WalletHandler {
  WalletHandler(
    this._store,
    this._addressService,
    this._contractService,
    this._configurationService,
  );

  final Store<Wallet, WalletAction> _store;
  final AddressService _addressService;
  final ConfigurationService _configurationService;
  final ContractService _contractService;

  Wallet get state => _store.state;

  Future<void> initialise() async {
    final entropyMnemonic = _configurationService.getMnemonic();
    final privateKey = _configurationService.getPrivateKey();

    if (entropyMnemonic != null && entropyMnemonic.isNotEmpty) {
      _initialiseFromMnemonic(entropyMnemonic);
      return;
    }

    _initialiseFromPrivateKey(privateKey);
  }

  Future<void> _initialiseFromMnemonic(String entropyMnemonic) async {
    final mnemonic = _addressService.entropyToMnemonic(entropyMnemonic);
    final privateKey = _addressService.getPrivateKey(mnemonic);
    final address = await _addressService.getPublicAddress(privateKey);

    _store.dispatch(InitialiseWallet(address.toString(), privateKey));

    await _initialise();
  }

  Future<void> _initialiseFromPrivateKey(String privateKey) async {
    final address = await _addressService.getPublicAddress(privateKey);

    _store.dispatch(InitialiseWallet(address.toString(), privateKey));

    await _initialise();
  }

  Future<void> _initialise() async {
    await this.fetchOwnBalance();

    _contractService.listenTransfer((from, to, value) async {
      var fromMe = from.toString() == state.address;
      var toMe = to.toString() == state.address;

      if (!fromMe && !toMe) {
        return;
      }

      print('======= balance updated =======');

      await fetchOwnBalance();
    });
  }

  Future<void> fetchOwnBalance() async {
    _store.dispatch(UpdatingBalance());

    var tokenBalance = await _contractService
        .getTokenBalance(web3.EthereumAddress.fromHex(state.address));

    var ethBalance = await _contractService
        .getEthBalance(web3.EthereumAddress.fromHex(state.address));

    _store.dispatch(BalanceUpdated(ethBalance.getInWei, tokenBalance));
  }

  Future<void> resetWallet() async {
    await _configurationService.setMnemonic(null);
    await _configurationService.setupDone(false);
  }
}
