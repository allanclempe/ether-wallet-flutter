import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:mobx/mobx.dart';

part 'wallet_create_store.g.dart';

class WalletCreateStore = WalletCreateStoreBase with _$WalletCreateStore;

enum WalletCreateSteps { display, confirm }

abstract class WalletCreateStoreBase with Store {
  WalletCreateStoreBase(this.walletStore, this._addressService);

  final WalletStore walletStore;
  final IAddressService _addressService;

  @observable
  String mnemonic;

  @observable
  String mnemonicConfirm;

  @observable
  WalletCreateSteps step = WalletCreateSteps.display;

  @observable
  ObservableList<String> errors = ObservableList<String>();

  @action
  void generateMnemonic() {
    this.reset();
    this.mnemonic = _addressService.generateMnemonic();
  }

  @action
  void setMnemonicConfirmation(String value) {
    this.errors.clear();
    this.mnemonicConfirm = value;
  }

  @action
  void goto(WalletCreateSteps step) {
    this.step = step;
  }

  @action
  void clearErrors() {
    this.errors = ObservableList();
  }

  @action
  void reset() {
    this.mnemonic = null;
    this.mnemonicConfirm = null;
    this.errors.clear();
    this.goto(WalletCreateSteps.display);
  }

  @action
  Future<bool> confirmMnemonic() async {
    if (mnemonicConfirm == mnemonic) {
      await _addressService.setupFromMnemonic(mnemonic);
      await walletStore.initialise();
      return true;
    }
    this.errors.clear();
    this.errors.add("Invalid mnemonic, please try again.");

    return false;
  }
}
