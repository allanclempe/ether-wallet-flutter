import 'package:etherwallet/service/address_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum WalletCreateSteps { display, confirm }

class CreateWalletState {
  CreateWalletState(
      {this.addressService, this.mnemonic, this.step, this.errors});

  final AddressService addressService;
  final ValueNotifier<String> mnemonic;
  final ValueNotifier<WalletCreateSteps> step;
  final ValueNotifier<List<String>> errors;

  bool get isDisplayStep => step.value == WalletCreateSteps.display;

  bool get isConfirmStep => step.value == WalletCreateSteps.confirm;

  void setMnemonic(String mnemonic) {
    this.mnemonic.value = mnemonic;
  }

  void generateMnemonic() {
    this.setMnemonic(addressService.generateMnemonic());
  }

  void goConfirm() {
    this.step.value = WalletCreateSteps.confirm;
  }

  void goDisplay() {
    this.step.value = WalletCreateSteps.display;
  }

  Future<bool> confirmMnemonic(String mnemonicConfirmation) async {
    var errors = new List<String>();
    if (mnemonicConfirmation == mnemonic.value) {
      await addressService.setupFromMnemonic(mnemonic.value);
      return true;
    }

    errors.add("Invalid mnemonic, please try again.");
    this.errors.value = errors;

    return false;
  }
}

CreateWalletState useCreateWalletState<T>(
    BuildContext context, IAddressService addressService) {
  final mnemonic = useState(addressService.generateMnemonic());

  final step = useState(WalletCreateSteps.display);
  final errors = useState<List<String>>([]);

  return CreateWalletState(
      mnemonic: mnemonic,
      addressService: addressService,
      step: step,
      errors: errors);
}
