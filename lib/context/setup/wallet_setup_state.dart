import 'package:etherwallet/model/wallet_setup.dart';

abstract class WalletSetupAction {}

class WalletSetupInit implements WalletSetupAction {}

class WalletSetupConfirmMnemonic implements WalletSetupAction {
  WalletSetupConfirmMnemonic(this.mnemonic);
  final String mnemonic;
}

class WalletSetupChangeStep implements WalletSetupAction {
  WalletSetupChangeStep(this.step);
  final WalletCreateSteps step;
}

class WalletSetupAddError implements WalletSetupAction {
  WalletSetupAddError(this.error);
  final String error;
}

class WalletSetupChangeMethod implements WalletSetupAction {
  WalletSetupChangeMethod(this.method);
  final WalletSetupMethod method;
}

class WalletSetupStarted implements WalletSetupAction {}

WalletSetup reducer(WalletSetup state, WalletSetupAction action) {
  if (action is WalletSetupInit) {
    return WalletSetup();
  }

  if (action is WalletSetupConfirmMnemonic) {
    return state.rebuild((b) => b
      ..mnemonic = action.mnemonic
      ..loading = true
      ..errors.clear());
  }

  if (action is WalletSetupStarted) {
    return state.rebuild((b) => b
      ..errors.clear()
      ..loading = true);
  }

  if (action is WalletSetupChangeStep) {
    return state.rebuild((b) => b
      ..step = action.step
      ..loading = false
      ..errors.clear());
  }

  if (action is WalletSetupChangeMethod) {
    return state.rebuild((b) => b
      ..method = action.method
      ..loading = false
      ..errors.clear());
  }

  if (action is WalletSetupAddError)
    return state.rebuild((b) => b
      ..loading = false
      ..errors.clear()
      ..errors.add(action.error));

  return state;
}
