import 'dart:async';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
    EthereumAddress from, EthereumAddress to, BigInt value);

abstract class IContractService {
  Future<Credentials> getCredentials(String privateKey);
  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer});
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription listenTransfer(TransferEvent onTransfer);
}

class ContractService implements IContractService {
  ContractService(this.client, this.contract);

  final Web3Client client;
  final DeployedContract contract;

  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractFunction _balanceFunction() => contract.function('balanceOf');
  ContractFunction _sendFunction() => contract.function('transfer');

  Future<Credentials> getCredentials(String privateKey) =>
      client.credentialsFromPrivateKey(privateKey);

  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer}) async {
    final credentials = await this.getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription event;
    // Work around once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value) async {
        onTransfer(from, to, value);
        await event.cancel();
      }, take: 1);
    }

    final transactionId = await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: _sendFunction(),
        parameters: [receiver, amount],
        from: from,
      ),
      chainId: networkId,
    );
    print('transact started $transactionId');
    return transactionId;
  }

  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return await client.getBalance(from);
  }

  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    var response = await client.call(
      contract: contract,
      function: _balanceFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  StreamSubscription listenTransfer(TransferEvent onTransfer, {int take}) {
    var events = client.events(FilterOptions.events(
      contract: contract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      final decoded = _transferEvent().decodeResults(event.topics, event.data);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      onTransfer(from, to, value);
    });
  }

  Future<void> dispose() async {
    await client.dispose();
  }
}
