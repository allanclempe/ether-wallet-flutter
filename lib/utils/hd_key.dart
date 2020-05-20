/*
* author: Aleksey Popov <alepooop@gmail.com>
* homepage: https://github.com/alepop/dart-ed25519-hd-key
*/

import 'dart:convert';
import 'dart:typed_data';
import 'package:tweetnacl/tweetnacl.dart' as ED25519;
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/api.dart';
import 'package:hex/hex.dart';

class KeyData {
  List<int> key;
  List<int> chainCode;
  KeyData({this.key, this.chainCode});
}

const String MASTER_SECRET = 'Bitcoin seed';
const int HARDENED_OFFSET = 0x80000000;

class _HDKey {
  static final _curveBytes = utf8.encode(MASTER_SECRET);
  static final _pathRegex = RegExp(r"^(m\/)?(\d+'?\/)*\d+'?$");

  const _HDKey();

  KeyData _getKeys(Uint8List data, Uint8List keyParameter) {
    final digest = SHA512Digest();
    final hmac = HMac(digest, 128)..init(KeyParameter(keyParameter));
    final I = hmac.process(data);
    final IL = I.sublist(0, 32);
    final IR = I.sublist(32);
    return KeyData(key: IL, chainCode: IR);
  }

  KeyData _getCKDPriv(KeyData data, int index) {
    Uint8List dataBytes = Uint8List(37);
    dataBytes[0] = 0x00;
    dataBytes.setRange(1, 33, data.key);
    dataBytes.buffer.asByteData().setUint32(33, index);
    return this._getKeys(dataBytes, data.chainCode);
  }

  KeyData getMasterKeyFromSeed(String seed) {
    final seedBytes = HEX.decode(seed);
    return this._getKeys(seedBytes, _HDKey._curveBytes);
  }

  Uint8List getBublickKey(Uint8List privateKey, [bool withZeroByte = true]) {
    final signature = ED25519.Signature.keyPair_fromSeed(privateKey);
    if (withZeroByte == true) {
      Uint8List dataBytes = Uint8List(33);
      dataBytes[0] = 0x00;
      dataBytes.setRange(1, 33, signature.publicKey);
      return dataBytes;
    } else {
      return signature.publicKey;
    }
  }

  KeyData derivePath(String path, String seed) {
    if (!_HDKey._pathRegex.hasMatch(path))
      throw ArgumentError(
          "Invalid derivation path. Expected BIP32 path format");
    KeyData master = this.getMasterKeyFromSeed(seed);
    List<String> segments = path.split('/');
    segments = segments.sublist(1);

    return segments.fold<KeyData>(master, (prevKeyData, indexStr) {
      int index = int.parse(indexStr.substring(0, indexStr.length - 1));
      return this._getCKDPriv(prevKeyData, index + HARDENED_OFFSET);
    });
  }
}

const HDKey = const _HDKey();
