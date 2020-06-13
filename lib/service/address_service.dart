import 'package:etherwallet/service/configuration_service.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:etherwallet/utils/hd_key.dart';
import "package:hex/hex.dart";
import 'package:web3dart/credentials.dart';

abstract class IAddressService {
  String generateMnemonic();
  String getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicAddress(String privateKey);
  Future<bool> setupFromMnemonic(String mnemonic);
  Future<bool> setupFromPrivateKey(String privateKey);
  String entropyToMnemonic(String entropyMnemonic);
}

class AddressService implements IAddressService {
  IConfigurationService _configService;
  AddressService(this._configService);

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  @override
  String getPrivateKey(String mnemonic) {
    String seed = bip39.mnemonicToSeedHex(mnemonic);
    KeyData master = HDKey.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    print("private: $privateKey");
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);

    final address = await private.extractAddress();
    print("address: $address");
    return address;
  }

  @override
  Future<bool> setupFromMnemonic(String mnemonic) async {
    final cryptMnemonic = bip39.mnemonicToEntropy(mnemonic);
    final privateKey = this.getPrivateKey(cryptMnemonic);

    await _configService.setMnemonic(cryptMnemonic);
    await _configService.setPrivateKey(privateKey);
    await _configService.setupDone(true);
    return true;
  }

  @override
  Future<bool> setupFromPrivateKey(String privateKey) async {
    await _configService.setMnemonic(null);
    await _configService.setPrivateKey(privateKey);
    await _configService.setupDone(true);
    return true;
  }
}
