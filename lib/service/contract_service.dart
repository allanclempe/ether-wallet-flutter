import 'dart:async';
import 'package:etherwallet/app_config.dart';
import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/utils/contract_parser.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  BigInt value,
);

abstract class IContractService {
  Future<Credentials> getCredentials(String privateKey);
  Future<String?> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent? onTransfer, Function(Object exeception)? onError});
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription listenTransfer(TransferEvent onTransfer);
}

class ContractServiceFactory {
  ContractServiceFactory(this.appConfig);

  final AppConfig appConfig;
  final Map<NetworkType, ContractService> _instances =
      <NetworkType, ContractService>{};

  Future<ContractService> getInstance(NetworkType network) async {
    final contractService =
        _instances[network] ?? await _setupInstance(network);

    _instances[network] = contractService;

    return contractService;
  }

  Future<ContractService> _setupInstance(NetworkType network) async {
    final networkConfig = appConfig.params[network];

    if (networkConfig == null) {
      throw Exception("Config for network '$network' could not be found");
    }

    final wsAddress = networkConfig.web3RdpUrl;
    final client = Web3Client(networkConfig.web3HttpUrl, Client(),
        socketConnector: wsAddress != null
            ? () => IOWebSocketChannel.connect(wsAddress).cast<String>()
            : null);

    final contract = await ContractParser.fromAssets(
        'TargaryenCoin.json', networkConfig.contractAddress);

    return ContractService(client, contract);
  }
}

class ContractService implements IContractService {
  ContractService(this.client, this.contract);

  final Web3Client client;
  final DeployedContract contract;

  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractFunction _balanceFunction() => contract.function('balanceOf');
  ContractFunction _sendFunction() => contract.function('transfer');

  @override
  Future<Credentials> getCredentials(String privateKey) =>
      client.credentialsFromPrivateKey(privateKey);

  @override
  Future<String?> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent? onTransfer, Function(Object exeception)? onError}) async {
    final credentials = await getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription? event;
    // Workaround once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value) async {
        onTransfer(from, to, value);
        await event?.cancel();
      }, take: 1);
    }

    try {
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
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  @override
  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return client.getBalance(from);
  }

  @override
  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    final response = await client.call(
      contract: contract,
      function: _balanceFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  @override
  StreamSubscription listenTransfer(TransferEvent onTransfer, {int? take}) {
    var events = client.events(FilterOptions.events(
      contract: contract,
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
    await client.dispose();
  }
}
