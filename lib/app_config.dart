import 'package:etherwallet/model/network_type.dart';

class AppConfig {
  AppConfig() {
    // params[NetworkType.local] = AppConfigParams('http://192.168.40.197:8545',
    //     '0xD933a953f4786Eed5E58D234dFeadE15c96bAa8b',
    //     web3RdpUrl: 'ws://192.168.40.197:8545');

    params[NetworkType.Ethereum] = AppConfigParams(
        'https://ropsten.infura.io/v3/628074215a2449eb960b4fe9e95feb09',
        '0x5060b60cb8Bd1C94B7ADEF4134555CDa7B45c461',
        web3RdpUrl:
            'wss://ropsten.infura.io/ws/v3/628074215a2449eb960b4fe9e95feb09');

    params[NetworkType.BSC] = AppConfigParams(
        'https://data-seed-prebsc-1-s1.binance.org:8545',
        '0x73434bb95eC80d623359f6f9d7b84568407187BA');

    params[NetworkType.Matic] = AppConfigParams(
        'https://rpc-mumbai.maticvigil.com',
        '0x73434bb95eC80d623359f6f9d7b84568407187BA',
        web3RdpUrl: 'wss://ws-mumbai.matic.today');
  }

  Map<NetworkType, AppConfigParams> params = <NetworkType, AppConfigParams>{};
}

class AppConfigParams {
  AppConfigParams(this.web3HttpUrl, this.contractAddress, {this.web3RdpUrl});
  final String? web3RdpUrl;
  final String web3HttpUrl;
  final String contractAddress;
}
