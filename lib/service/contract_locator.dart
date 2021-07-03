import 'package:etherwallet/app_config.dart';
import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:etherwallet/utils/contract_parser.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

class ContractLocator {
  ContractLocator._();

  static Map<NetworkType, ContractService> instance =
      <NetworkType, ContractService>{};

  static Future<ContractLocator> setup(AppConfig appConfig) async {
    for (final network in appConfig.params.keys) {
      instance[network] = await createInstance(appConfig.params[network]!);
    }

    return ContractLocator._();
  }

  ContractService getInstance(NetworkType network) {
    return instance[network]!;
  }

  static Future<ContractService> createInstance(
      AppConfigParams networkConfig) async {
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
