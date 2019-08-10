// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transfer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$WalletTransferStore on WalletTransferStoreBase, Store {
  final _$toAtom = Atom(name: 'WalletTransferStoreBase.to');

  @override
  String get to {
    _$toAtom.context.enforceReadPolicy(_$toAtom);
    _$toAtom.reportObserved();
    return super.to;
  }

  @override
  set to(String value) {
    _$toAtom.context.conditionallyRunInAction(() {
      super.to = value;
      _$toAtom.reportChanged();
    }, _$toAtom, name: '${_$toAtom.name}_set');
  }

  final _$amountAtom = Atom(name: 'WalletTransferStoreBase.amount');

  @override
  String get amount {
    _$amountAtom.context.enforceReadPolicy(_$amountAtom);
    _$amountAtom.reportObserved();
    return super.amount;
  }

  @override
  set amount(String value) {
    _$amountAtom.context.conditionallyRunInAction(() {
      super.amount = value;
      _$amountAtom.reportChanged();
    }, _$amountAtom, name: '${_$amountAtom.name}_set');
  }

  final _$errorsAtom = Atom(name: 'WalletTransferStoreBase.errors');

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

  final _$loadingAtom = Atom(name: 'WalletTransferStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$WalletTransferStoreBaseActionController =
      ActionController(name: 'WalletTransferStoreBase');

  @override
  void setTo(String value) {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.setTo(value);
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(String value) {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.setAmount(value);
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoading(bool value) {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.isLoading(value);
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String message) {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.setError(message);
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<Transaction> transfer() {
    final _$actionInfo =
        _$WalletTransferStoreBaseActionController.startAction();
    try {
      return super.transfer();
    } finally {
      _$WalletTransferStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
