import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/model/wallet.dart';

abstract class WalletAction {}

class WalletInit extends WalletAction {}

class InitialiseWallet extends WalletAction {
  InitialiseWallet(this.network, this.address, this.privateKey);
  final NetworkType network;
  final String address;
  final String privateKey;
}

class NetworkChanged extends WalletAction {
  NetworkChanged(this.network);
  final NetworkType network;
}

class BalanceUpdated extends WalletAction {
  BalanceUpdated(this.ethBalance, this.tokenBalance);
  final BigInt ethBalance;
  final BigInt tokenBalance;
}

class UpdatingBalance extends WalletAction {}

Wallet reducer(Wallet state, WalletAction action) {
  if (action is WalletInit) {
    return Wallet();
  }

  if (action is InitialiseWallet) {
    return state.rebuild((b) => b
      ..network = action.network
      ..address = action.address
      ..privateKey = action.privateKey);
  }

  if (action is NetworkChanged) {
    return state.rebuild((b) => b..network = action.network);
  }

  if (action is UpdatingBalance) {
    return state.rebuild((b) => b..loading = true);
  }

  if (action is BalanceUpdated) {
    return state.rebuild((b) => b
      ..loading = false
      ..ethBalance = action.ethBalance
      ..tokenBalance = action.tokenBalance);
  }

  return state;
}
