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
      enabled: false,
      label: 'Local (Truffle)',
    ),
    NetworkType.Ethereum: AppConfigParams(
      'https://goerli.infura.io/v3/628074215a2449eb960b4fe9e95feb09',
      '0x3B4c8de78c34773f5A1A656691734641f99066A1',
      symbol: 'ETH',
      faucetUrl: 'https://goerlifaucet.com',
      enabled: true,
      icon: WalletIcons.ethereum,
      label: 'Ethereum (Goerli)',
    ),
    NetworkType.BSC: AppConfigParams(
      'https://data-seed-prebsc-1-s1.binance.org:8545',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      symbol: 'BNB',
      faucetUrl: 'https://testnet.binance.org/faucet-smart',
      enabled: true,
      label: 'Binance Chain (BSC)',
    ),
    NetworkType.Matic: AppConfigParams(
      'https://rpc-mumbai.maticvigil.com',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      web3RdpUrl: 'wss://ws-mumbai.matic.today',
      symbol: 'MATIC',
      faucetUrl: 'https://faucet.matic.network',
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
}
