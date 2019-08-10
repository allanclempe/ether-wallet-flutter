import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:mobx/mobx.dart';

part 'wallet_import_store.g.dart';

class WalletImportStore = WalletImportStoreBase with _$WalletImportStore;

enum WalletImportType { mnemonic, privateKey }

abstract class WalletImportStoreBase with Store {
  WalletImportStoreBase(this.walletStore, this._addressService);

  final WalletStore walletStore;
  final IAddressService _addressService;

  @observable
  WalletImportType type = WalletImportType.mnemonic;

  @observable
  String mnemonic;

  @observable
  String privateKey;

  @observable
  ObservableList<String> errors = ObservableList<String>();

  @action
  void reset() {
    this.mnemonic = null;
    this.privateKey = null;
    this.type = WalletImportType.mnemonic;
  }

  @action
  void setMnemonic(String value) {
    this.errors.clear();
    this.mnemonic = value;
  }

  @action
  void setType(WalletImportType value) {
    this.errors.clear();
    this.type = value;
  }

  @action
  void setPrivateKey(String value) {
    this.errors.clear();
    this.privateKey = value;
  }

  @action
  Future<bool> confirmMnemonic() async {
    this.errors.clear();
    try {
      if (_validateMnemonic(mnemonic)) {
        final normalisedMnemonic = _mnemonicNormalise(mnemonic);
        await _addressService.setupFromMnemonic(normalisedMnemonic);
        await walletStore.initialise();
        return true;
      }
    } catch (e) {
      this.errors.add(e.toString());
    }

    this.errors.add("Invalid mnemonic, it requires 12 words.");

    return false;
  }

  @action
  Future<bool> confirmPrivateKey() async {
    this.errors.clear();
    try {
      await _addressService.setupFromPrivateKey(privateKey);
      await walletStore.initialise();
      return true;
    } catch (e) {
      this.errors.add(e.toString());
    }

    this.errors.add("Invalid private key, please try again.");

    return false;
  }

  String _mnemonicNormalise(String mnemonic) {
    return _mnemonicWords(mnemonic).join(" ");
  }

  List<String> _mnemonicWords(String mnemonic) {
    return mnemonic
        .split(" ")
        .where((item) => item != null && item.trim().isNotEmpty)
        .map((item) => item.trim())
        .toList();
  }

  bool _validateMnemonic(String mnemonic) {
    return _mnemonicWords(mnemonic).length == 12;
  }
}
