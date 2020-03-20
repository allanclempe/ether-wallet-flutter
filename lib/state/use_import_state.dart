import 'package:etherwallet/service/address_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ImportWalletState {
  ImportWalletState({this.errors, this.addressService});
  final ValueNotifier<List<String>> errors;
  final IAddressService addressService;

  Future<bool> confirmMnemonic(String mnemonic) async {
    var errors = List<String>();

    try {
      if (_validateMnemonic(mnemonic)) {
        final normalisedMnemonic = _mnemonicNormalise(mnemonic);
        await addressService.setupFromMnemonic(normalisedMnemonic);
        return true;
      }
    } catch (e) {
      errors.add(e.toString());
    }

    errors.add("Invalid mnemonic, it requires 12 words.");
    this.errors.value = errors;

    return false;
  }

  Future<bool> confirmPrivateKey(String privateKey) async {
    var errors = List<String>();
    try {
      await addressService.setupFromPrivateKey(privateKey);
      return true;
    } catch (e) {
      errors.add(e.toString());
    }

    errors.add("Invalid private key, please try again.");
    this.errors.value = errors;

    return false;
  }

  String _mnemonicNormalise(String mnemonic) {
    return _mnemonicWords(mnemonic).join(" ");
  }

  List<String> _mnemonicWords(String mnemonic) {
    return mnemonic
        .split(" ")
        .where((item) => item != null && item.trim().isNotEmpty)
        .map((item) => item.trim())
        .toList();
  }

  bool _validateMnemonic(String mnemonic) {
    return _mnemonicWords(mnemonic).length == 12;
  }
}

ImportWalletState useImportWalletState<T>(BuildContext context) {
  final addressService = Provider.of<AddressService>(context);
  final errors = useState<List<String>>([]);

  return ImportWalletState(addressService: addressService, errors: errors);
}
