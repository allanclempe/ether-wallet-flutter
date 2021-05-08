import 'package:etherwallet/service/configuration_service.dart';

class ConfigServiceMock implements IConfigurationService {
  @override
  bool didSetupWallet() {
    // TODO: implement didSetupWallet
    throw UnimplementedError();
  }

  @override
  String? getMnemonic() {
    // TODO: implement getMnemonic
    throw UnimplementedError();
  }

  @override
  String? getPrivateKey() {
    // TODO: implement getPrivateKey
    throw UnimplementedError();
  }

  @override
  Future<void> setMnemonic(String? value) {
    // TODO: implement setMnemonic
    throw UnimplementedError();
  }

  @override
  Future<void> setPrivateKey(String? value) {
    // TODO: implement setPrivateKey
    throw UnimplementedError();
  }

  @override
  Future<void> setupDone(bool value) {
    // TODO: implement setupDone
    throw UnimplementedError();
  }
}
