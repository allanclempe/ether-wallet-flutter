import 'dart:async';
import 'dart:math';
import 'package:etherwallet/model/transaction.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:etherwallet/stores/wallet_store.dart';
import 'package:mobx/mobx.dart';
import 'package:web3dart/credentials.dart';

part 'wallet_transfer_store.g.dart';

class WalletTransferStore = WalletTransferStoreBase with _$WalletTransferStore;

abstract class WalletTransferStoreBase with Store {
  WalletTransferStoreBase(this.walletStore, this._contractService);

  final WalletStore walletStore;
  final IContractService _contractService;

  @observable
  String to;
  @observable
  String amount;
  @observable
  ObservableList<String> errors = ObservableList<String>();
  @observable
  bool loading;

  @action
  void setTo(String value) {
    this.to = value;
  }

  @action
  void setAmount(String value) {
    this.amount = value;
  }

  @action
  void isLoading(bool value) {
    this.loading = value;
  }

  @action
  void reset() {
    this.to = "";
    this.amount = "";
    this.loading = false;
    this.errors.clear();
  }

  @action
  void setError(String message) {
    isLoading(false);

    this.errors.clear();
    this.errors.add(message);
  }

  @action
  Stream<Transaction> transfer() {
    var controller = StreamController<Transaction>();
    var transactionEvent = Transaction();

    isLoading(true);

    try {
      _contractService.send(
        walletStore.privateKey,
        EthereumAddress.fromHex(this.to),
        BigInt.from(double.parse(this.amount) * pow(10, 18)),
        onTransfer: (from, to, value) {
          controller.add(transactionEvent.confirmed(from, to, value));
          controller.close();
          isLoading(false);
        },
      ).then((id) => controller.add(transactionEvent.setId(id)));
    } catch (ex) {
      controller.addError(ex);
      isLoading(false);
    }

    return controller.stream;
  }
}
