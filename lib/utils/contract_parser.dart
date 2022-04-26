import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';

// ignore: avoid_classes_with_only_static_members
class ContractParser {
  static Future<DeployedContract> fromAssets(
      String path, String contractAddress) async {
    final contractJson =
        jsonDecode(await rootBundle.loadString('assets/TargaryenCoin.json'));

    return DeployedContract(
        ContractAbi.fromJson(jsonEncode(contractJson['abi']),
            contractJson['contractName'] as String),
        EthereumAddress.fromHex(contractAddress));
  }
}
