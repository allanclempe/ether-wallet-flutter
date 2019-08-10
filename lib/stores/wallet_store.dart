import 'dart:async';
import 'package:etherwallet/model/transaction.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:mobx/mobx.dart';
import 'package:web3dart/credentials.dart';

part 'wallet_store.g.dart';

class WalletStore = WalletStoreBase with _$WalletStore;

abstract class WalletStoreBase with Store {
  WalletStoreBase(
    this._contractService,
    this._addressService,
    this._configurationService,
  );

  final IContractService _contractService;
  final IAddressService _addressService;
  final IConfigurationService _configurationService;

  @observable
  BigInt tokenBalance;

  @observable
  BigInt ethBalance;

  @observable
  String address;

  @observable
  String privateKey;

  @observable
  ObservableList<Transaction> transactions = ObservableList<Transaction>();

  @action
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

    this.address = address.toString();
    this.privateKey = privateKey;

    await _initialise();
  }

  Future<void> _initialiseFromPrivateKey(String privateKey) async {
    final address = await _addressService.getPublicAddress(privateKey);

    this.address = address.toString();
    this.privateKey = privateKey;

    await _initialise();
  }

  Future<void> _initialise() async {
    await this.fetchOwnBalance();

    _contractService.listenTransfer((from, to, value) async {
      var fromMe = from.toString() == this.address;
      var toMe = to.toString() == this.address;

      if (!fromMe && !toMe) {
        return;
      }

      await fetchOwnBalance();
    });
  }

  @action
  Future<void> fetchOwnBalance() async {
    var tokenBalance = await _contractService
        .getTokenBalance(EthereumAddress.fromHex(address));
    var ethBalance =
        await _contractService.getEthBalance(EthereumAddress.fromHex(address));

    this.tokenBalance = tokenBalance;
    this.ethBalance = ethBalance.getInWei;
  }

  @action
  Future<void> resetWallet() async {
    await _configurationService.setMnemonic(null);
    await _configurationService.setupDone(false);

    this.transactions.clear();
  }
}
