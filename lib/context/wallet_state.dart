import 'package:etherwallet/model/wallet.dart';

abstract class WalletAction {}

class InitialiseWallet extends WalletAction {
  InitialiseWallet(this.address, this.privateKey);
  final String address;
  final String privateKey;
}

class UpdateBalance extends WalletAction {
  UpdateBalance(this.ethBalance, this.tokenBalance);
  final BigInt ethBalance;
  final BigInt tokenBalance;
}

Wallet reducer(Wallet state, WalletAction action) {
  if (action is InitialiseWallet) {
    return state.rebuild((b) => b
      ..address = action.address
      ..privateKey = action.privateKey);
  }

  if (action is UpdateBalance) {
    return state.rebuild((b) => b
      ..ethBalance = action.ethBalance
      ..tokenBalance = action.tokenBalance);
  }

  return state;
}
