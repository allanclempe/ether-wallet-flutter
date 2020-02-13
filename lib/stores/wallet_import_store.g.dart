// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_import_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletImportStore on WalletImportStoreBase, Store {
  final _$typeAtom = Atom(name: 'WalletImportStoreBase.type');

  @override
  WalletImportType get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(WalletImportType value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$mnemonicAtom = Atom(name: 'WalletImportStoreBase.mnemonic');

  @override
  String get mnemonic {
    _$mnemonicAtom.context.enforceReadPolicy(_$mnemonicAtom);
    _$mnemonicAtom.reportObserved();
    return super.mnemonic;
  }

  @override
  set mnemonic(String value) {
    _$mnemonicAtom.context.conditionallyRunInAction(() {
      super.mnemonic = value;
      _$mnemonicAtom.reportChanged();
    }, _$mnemonicAtom, name: '${_$mnemonicAtom.name}_set');
  }

  final _$privateKeyAtom = Atom(name: 'WalletImportStoreBase.privateKey');

  @override
  String get privateKey {
    _$privateKeyAtom.context.enforceReadPolicy(_$privateKeyAtom);
    _$privateKeyAtom.reportObserved();
    return super.privateKey;
  }

  @override
  set privateKey(String value) {
    _$privateKeyAtom.context.conditionallyRunInAction(() {
      super.privateKey = value;
      _$privateKeyAtom.reportChanged();
    }, _$privateKeyAtom, name: '${_$privateKeyAtom.name}_set');
  }

  final _$errorsAtom = Atom(name: 'WalletImportStoreBase.errors');

  @override
  ObservableList<String> get errors {
    _$errorsAtom.context.enforceReadPolicy(_$errorsAtom);
    _$errorsAtom.reportObserved();
    return super.errors;
  }

  @override
  set errors(ObservableList<String> value) {
    _$errorsAtom.context.conditionallyRunInAction(() {
      super.errors = value;
      _$errorsAtom.reportChanged();
    }, _$errorsAtom, name: '${_$errorsAtom.name}_set');
  }

  final _$confirmMnemonicAsyncAction = AsyncAction('confirmMnemonic');

  @override
  Future<bool> confirmMnemonic() {
    return _$confirmMnemonicAsyncAction.run(() => super.confirmMnemonic());
  }

  final _$confirmPrivateKeyAsyncAction = AsyncAction('confirmPrivateKey');

  @override
  Future<bool> confirmPrivateKey() {
    return _$confirmPrivateKeyAsyncAction.run(() => super.confirmPrivateKey());
  }

  final _$WalletImportStoreBaseActionController =
      ActionController(name: 'WalletImportStoreBase');

  @override
  void reset() {
    final _$actionInfo = _$WalletImportStoreBaseActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$WalletImportStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMnemonic(String value) {
    final _$actionInfo = _$WalletImportStoreBaseActionController.startAction();
    try {
      return super.setMnemonic(value);
    } finally {
      _$WalletImportStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setType(WalletImportType value) {
    final _$actionInfo = _$WalletImportStoreBaseActionController.startAction();
    try {
      return super.setType(value);
    } finally {
      _$WalletImportStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrivateKey(String value) {
    final _$actionInfo = _$WalletImportStoreBaseActionController.startAction();
    try {
      return super.setPrivateKey(value);
    } finally {
      _$WalletImportStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
