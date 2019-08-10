import 'package:web3dart/web3dart.dart';

class Transaction {
  Transaction() {
    date = DateTime.now();
    status = TransactionStatus.started;
  }

  String key;
  String from;
  String to;
  DateTime date;
  String receipt; // TODO: how to get receipt?
  BigInt value;
  TransactionStatus status;

  Transaction setId(String key) {
    this.key = key;
    return this;
  }

  Transaction confirmed(
      EthereumAddress from, EthereumAddress to, BigInt value) {
    this.status = TransactionStatus.confirmed;
    this.from = from.toString();
    this.to = to.toString();
    this.value = value;
    return this;
  }
}

enum TransactionStatus {
  started,
  confirmed,
}
