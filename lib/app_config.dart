import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static Map<NetworkType, AppConfigParams> networks =
      <NetworkType, AppConfigParams>{
    NetworkType.Local: AppConfigParams(
      'http://192.168.40.197:8545',
      '0xD933a953f4786Eed5E58D234dFeadE15c96bAa8b',
      web3RdpUrl: 'ws://192.168.40.197:8545',
      symbol: 'ETH',
      faucetUrl: 'about:blank',
      explorerUrl: 'about:blank',
      enabled: false,
      label: 'Local (Truffle)',
    ),

    // If you are forking the project and will build on top of this boiler plate, please
    // create your onw nodes on infura.io or getblock.io
    NetworkType.Ethereum: AppConfigParams(
      'https://eth.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/goerli/',
      '0x3B4c8de78c34773f5A1A656691734641f99066A1',
      web3RdpUrl:
          'wss://eth.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/goerli/',
      symbol: 'ETH',
      faucetUrl: 'https://goerlifaucet.com',
      explorerUrl: 'https://goerli.etherscan.io',
      enabled: true,
      icon: WalletIcons.ethereum,
      label: 'Ethereum (Goerli)',
    ),
    NetworkType.BSC: AppConfigParams(
      'https://bsc.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      web3RdpUrl:
          'wss://bsc.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
      symbol: 'BNB',
      faucetUrl: 'https://testnet.binance.org/faucet-smart',
      explorerUrl: 'https://testnet.bscscan.com',
      enabled: true,
      label: 'Binance Chain (BSC)',
    ),
    NetworkType.Matic: AppConfigParams(
      'https://matic.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      web3RdpUrl:
          'wss://matic.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
      symbol: 'MATIC',
      faucetUrl: 'https://faucet.matic.network',
      explorerUrl: 'https://mumbai.polygonscan.com',
      enabled: true,
      label: 'Matic (Mumbai)',
    )
  };
}

class AppConfigParams {
  AppConfigParams(
    this.web3HttpUrl,
    this.contractAddress, {
    required this.symbol,
    required this.faucetUrl,
    required this.enabled,
    required this.label,
    required this.explorerUrl,
    this.web3RdpUrl,
    this.icon = WalletIcons.coins,
  });
  final String? web3RdpUrl;
  final String web3HttpUrl;
  final String contractAddress;
  final String symbol;
  final String faucetUrl;
  final IconData icon;
  final bool enabled;
  final String label;
  final String explorerUrl;
}
