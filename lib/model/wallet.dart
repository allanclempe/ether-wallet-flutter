import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'wallet.g.dart';

abstract class Wallet implements Built<Wallet, WalletBuilder> {
  factory Wallet([void Function(WalletBuilder)? updates]) => _$Wallet((b) => b
    ..tokenBalance = BigInt.from(0)
    ..ethBalance = BigInt.from(0)
    ..errors = BuiltList<String>().toBuilder()
    ..loading = false
    ..update(updates));

  Wallet._();

  String? get address;

  String? get privateKey;

  BigInt get tokenBalance;

  BigInt get ethBalance;

  bool get loading;

  BuiltList<String>? get errors;
}
