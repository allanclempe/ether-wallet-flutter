import 'package:web3dart/web3dart.dart';

class EthAmountFormatter {
  EthAmountFormatter(this.amount);

  final BigInt? amount;

  String format({
    EtherUnit fromUnit = EtherUnit.wei,
    EtherUnit toUnit = EtherUnit.ether,
  }) {
    if (amount == null) {
      return '-';
    }

    return EtherAmount.fromBigInt(fromUnit, amount!)
        .getValueInUnit(toUnit)
        .toString();
  }
}
