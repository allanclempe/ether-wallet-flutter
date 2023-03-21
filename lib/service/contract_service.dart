import 'dart:async';
import 'package:web3dart/web3dart.dart';

import '../model/wallet_transfer.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  BigInt value,
);

abstract class IContractService {
  EthPrivateKey getCredentials(String privateKey);
  Future<String?> send(
    String privateKey,
    WalletTransferType type,
    EthereumAddress receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  });
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer);
}

class ContractService implements IContractService {
  ContractService(this._client, this._contract);

  final Web3Client _client;
  final DeployedContract _contract;

  ContractEvent _transferEvent() => _contract.event('Transfer');
  ContractFunction _balanceFunction() => _contract.function('balanceOf');
  ContractFunction _sendFunction() => _contract.function('transfer');

  @override
  EthPrivateKey getCredentials(String privateKey) =>
      EthPrivateKey.fromHex(privateKey);

  @override
  Future<String?> send(
    String privateKey,
    WalletTransferType type,
    EthereumAddress receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  }) async {
    final credentials = getCredentials(privateKey);
    final from = credentials.address;
    final networkId = await _client.getNetworkId();

    final gasPrice = await _client.getGasPrice();
    final transaction = type == WalletTransferType.ether
        ? Transaction(
            from: from,
            to: receiver,
            gasPrice: gasPrice,
            value: amount,
          )
        : Transaction.callContract(
            contract: _contract,
            function: _sendFunction(),
            parameters: [receiver, amount.getInWei],
            gasPrice: gasPrice,
            from: from,
          );

    try {
      final transactionId = await _client.sendTransaction(
        credentials,
        transaction,
        chainId: networkId,
      );

      // pooling the transaction receipt every x seconds.
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        final receipt = await _client.getTransactionReceipt(transactionId);

        if (receipt?.status ?? false) {
          if (onTransfer != null) {
            onTransfer(from, receiver, amount.getInEther);
          }

          timer.cancel();
        }
      });

      print('transact started $transactionId');

      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  @override
  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return _client.getBalance(from);
  }

  @override
  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    final response = await _client.call(
      contract: _contract,
      function: _balanceFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  @override
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer,
      {int? take}) {
    var events = _client.events(FilterOptions.events(
      contract: _contract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      if (event.topics == null || event.data == null) {
        return;
      }

      final decoded =
          _transferEvent().decodeResults(event.topics!, event.data!);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from}');
      print('$to}');
      print('$value}');

      onTransfer(from, to, value);
    });
  }

  @override
  Future<void> dispose() async {
    await _client.dispose();
  }
}
