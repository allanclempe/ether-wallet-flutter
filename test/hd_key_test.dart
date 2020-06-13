import 'package:bip39/bip39.dart' as bip39;
import 'package:etherwallet/utils/hd_key.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:hex/hex.dart";

void main() {
  group("Test seed", () {
    test("should have valid key", () {
      String seed = bip39.mnemonicToSeedHex("thought empty modify achieve arch tooth sign unhappy life tape team dust");
      var master = HDKey.getMasterKeyFromSeed(seed);
      expect(
          HEX.encode(master.key),
          equals(
              "1352d9efc5c511f89ff262f913e58a2d42649d47246752790cbce6987e100bfe"));
    });
  });
}
