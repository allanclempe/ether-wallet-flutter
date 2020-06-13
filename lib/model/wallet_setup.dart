import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'wallet_setup.g.dart';

enum WalletSetupMethod { fromMnemonic, fromPrivateKey, create }

enum WalletCreateSteps { display, confirm }

enum WalletImportType { mnemonic, privateKey }

abstract class WalletSetup implements Built<WalletSetup, WalletSetupBuilder> {
  @nullable
  String get mnemonic;

  @nullable
  String get privateKey;

  WalletCreateSteps get step;
  WalletSetupMethod get method;
  bool get loading;
  @nullable
  BuiltList<String> get errors;

  WalletSetup._();
  factory WalletSetup([void Function(WalletSetupBuilder) updates]) =>
      _$WalletSetup((b) => b
        ..step = WalletCreateSteps.display
        ..method = WalletSetupMethod.create
        ..loading = false
        ..errors = BuiltList<String>().toBuilder()
        ..update(updates));
}
