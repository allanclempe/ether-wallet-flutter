// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Wallet extends Wallet {
  @override
  final String address;
  @override
  final String privateKey;
  @override
  final BigInt tokenBalance;
  @override
  final BigInt ethBalance;
  @override
  final bool loading;
  @override
  final BuiltList<String> errors;

  factory _$Wallet([void Function(WalletBuilder) updates]) =>
      (new WalletBuilder()..update(updates)).build();

  _$Wallet._(
      {this.address,
      this.privateKey,
      this.tokenBalance,
      this.ethBalance,
      this.loading,
      this.errors})
      : super._() {
    if (tokenBalance == null) {
      throw new BuiltValueNullFieldError('Wallet', 'tokenBalance');
    }
    if (ethBalance == null) {
      throw new BuiltValueNullFieldError('Wallet', 'ethBalance');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('Wallet', 'loading');
    }
  }

  @override
  Wallet rebuild(void Function(WalletBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletBuilder toBuilder() => new WalletBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Wallet &&
        address == other.address &&
        privateKey == other.privateKey &&
        tokenBalance == other.tokenBalance &&
        ethBalance == other.ethBalance &&
        loading == other.loading &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, address.hashCode), privateKey.hashCode),
                    tokenBalance.hashCode),
                ethBalance.hashCode),
            loading.hashCode),
        errors.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Wallet')
          ..add('address', address)
          ..add('privateKey', privateKey)
          ..add('tokenBalance', tokenBalance)
          ..add('ethBalance', ethBalance)
          ..add('loading', loading)
          ..add('errors', errors))
        .toString();
  }
}

class WalletBuilder implements Builder<Wallet, WalletBuilder> {
  _$Wallet _$v;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _privateKey;
  String get privateKey => _$this._privateKey;
  set privateKey(String privateKey) => _$this._privateKey = privateKey;

  BigInt _tokenBalance;
  BigInt get tokenBalance => _$this._tokenBalance;
  set tokenBalance(BigInt tokenBalance) => _$this._tokenBalance = tokenBalance;

  BigInt _ethBalance;
  BigInt get ethBalance => _$this._ethBalance;
  set ethBalance(BigInt ethBalance) => _$this._ethBalance = ethBalance;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  ListBuilder<String> _errors;
  ListBuilder<String> get errors =>
      _$this._errors ??= new ListBuilder<String>();
  set errors(ListBuilder<String> errors) => _$this._errors = errors;

  WalletBuilder();

  WalletBuilder get _$this {
    if (_$v != null) {
      _address = _$v.address;
      _privateKey = _$v.privateKey;
      _tokenBalance = _$v.tokenBalance;
      _ethBalance = _$v.ethBalance;
      _loading = _$v.loading;
      _errors = _$v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Wallet other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Wallet;
  }

  @override
  void update(void Function(WalletBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Wallet build() {
    _$Wallet _$result;
    try {
      _$result = _$v ??
          new _$Wallet._(
              address: address,
              privateKey: privateKey,
              tokenBalance: tokenBalance,
              ethBalance: ethBalance,
              loading: loading,
              errors: _errors?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Wallet', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
