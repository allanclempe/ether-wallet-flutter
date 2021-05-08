// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:cryptography/cryptography.dart';

// class KeyData {
//   final List<int> key;
//   final List<int> chainCode;

//   const KeyData({required this.key, required this.chainCode});
// }

// // Supported curve
// const ED25519_HD_KEY = _ED25519HD();
// const int HARDENED_OFFSET = 0x80000000;

// /// Implementation of ED25519 private key derivation from master private key
// class _ED25519HD {
//   static final _curveBytes = utf8.encode('Bitcoin seed');
//   static final _pathRegex = RegExp(r"^(m\/)?(\d+'?\/)*\d+'?$");

//   const _ED25519HD();

//   Future<KeyData> derivePath(String path, List<int> seedBytes,
//       {int offset = HARDENED_OFFSET}) async {
//     if (!_ED25519HD._pathRegex.hasMatch(path)) {
//       throw ArgumentError(
//           "Invalid derivation path. Expected BIP32 path format");
//     }

//     KeyData master = await getMasterKeyFromSeed(seedBytes);

//     List<String> segments = path.split('/');
//     segments = segments.sublist(1);

//     KeyData result = master;

//     for (String segment in segments) {
//       int index = int.parse(segment.substring(0, segment.length - 1));
//       result = await _getCKDPriv(result, index + offset);
//     }

//     return result;
//   }

//   Future<KeyData> getMasterKeyFromSeed(List<int> seedBytes) =>
//       _getKeys(seedBytes, _ED25519HD._curveBytes);

//   Future<List<int>> getPublicKey(List<int> privateKey,
//       [bool withZeroByte = true]) async {
//     final algorithm = Ed25519();
//     final signature = await algorithm.newKeyPairFromSeed(privateKey);
//     final publicKey = await signature.extractPublicKey();

//     if (withZeroByte == true) {
//       List<int> dataBytes = List.filled(33, 0);
//       dataBytes[0] = 0x00;
//       dataBytes.setRange(1, 33, publicKey.bytes);
//       return dataBytes;
//     } else {
//       return publicKey.bytes;
//     }
//   }

//   Future<KeyData> _getCKDPriv(KeyData data, int index) {
//     Uint8List dataBytes = Uint8List(37);
//     dataBytes[0] = 0x00;
//     dataBytes.setRange(1, 33, data.key);
//     dataBytes.buffer.asByteData().setUint32(33, index);
//     return _getKeys(dataBytes, data.chainCode);
//   }

//   Future<KeyData> _getKeys(List<int> data, List<int> keyParameter) async {
//     final hmac = Hmac.sha512();
//     final sink = await hmac.newMacSink(secretKey: SecretKey(keyParameter));
//     sink
//       ..add(data)
//       ..close();

//     final mac = await sink.mac();

//     final I = mac.bytes;
//     final IL = I.sublist(0, 32);
//     final IR = I.sublist(32);

//     return KeyData(key: IL, chainCode: IR);
//   }
// }
