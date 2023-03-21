import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'wallet_transfer.g.dart';

enum WalletTransferStatus { started, confirmed, none }

enum WalletTransferType { ether, token }

abstract class WalletTransfer
    implements Built<WalletTransfer, WalletTransferBuilder> {
  factory WalletTransfer([void Function(WalletTransferBuilder)? updates]) =>
      _$WalletTransfer((b) => b
        ..errors = BuiltList<String>().toBuilder()
        ..status = WalletTransferStatus.none
        ..loading = false
        ..update(updates));

  WalletTransfer._();

  BuiltList<String>? get errors;

  WalletTransferStatus get status;

  String? get transactionId;

  bool get loading;
}
