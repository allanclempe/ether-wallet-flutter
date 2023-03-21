// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Wallet extends Wallet {
  @override
  final NetworkType network;
  @override
  final String? address;
  @override
  final String? privateKey;
  @override
  final BigInt tokenBalance;
  @override
  final BigInt ethBalance;
  @override
  final bool loading;
  @override
  final BuiltList<String>? errors;

  factory _$Wallet([void Function(WalletBuilder)? updates]) =>
      (new WalletBuilder()..update(updates))._build();

  _$Wallet._(
      {required this.network,
      this.address,
      this.privateKey,
      required this.tokenBalance,
      required this.ethBalance,
      required this.loading,
      this.errors})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(network, r'Wallet', 'network');
    BuiltValueNullFieldError.checkNotNull(
        tokenBalance, r'Wallet', 'tokenBalance');
    BuiltValueNullFieldError.checkNotNull(ethBalance, r'Wallet', 'ethBalance');
    BuiltValueNullFieldError.checkNotNull(loading, r'Wallet', 'loading');
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
        network == other.network &&
        address == other.address &&
        privateKey == other.privateKey &&
        tokenBalance == other.tokenBalance &&
        ethBalance == other.ethBalance &&
        loading == other.loading &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, privateKey.hashCode);
    _$hash = $jc(_$hash, tokenBalance.hashCode);
    _$hash = $jc(_$hash, ethBalance.hashCode);
    _$hash = $jc(_$hash, loading.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Wallet')
          ..add('network', network)
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
  _$Wallet? _$v;

  NetworkType? _network;
  NetworkType? get network => _$this._network;
  set network(NetworkType? network) => _$this._network = network;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _privateKey;
  String? get privateKey => _$this._privateKey;
  set privateKey(String? privateKey) => _$this._privateKey = privateKey;

  BigInt? _tokenBalance;
  BigInt? get tokenBalance => _$this._tokenBalance;
  set tokenBalance(BigInt? tokenBalance) => _$this._tokenBalance = tokenBalance;

  BigInt? _ethBalance;
  BigInt? get ethBalance => _$this._ethBalance;
  set ethBalance(BigInt? ethBalance) => _$this._ethBalance = ethBalance;

  bool? _loading;
  bool? get loading => _$this._loading;
  set loading(bool? loading) => _$this._loading = loading;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors =>
      _$this._errors ??= new ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  WalletBuilder();

  WalletBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _network = $v.network;
      _address = $v.address;
      _privateKey = $v.privateKey;
      _tokenBalance = $v.tokenBalance;
      _ethBalance = $v.ethBalance;
      _loading = $v.loading;
      _errors = $v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Wallet other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Wallet;
  }

  @override
  void update(void Function(WalletBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Wallet build() => _build();

  _$Wallet _build() {
    _$Wallet _$result;
    try {
      _$result = _$v ??
          new _$Wallet._(
              network: BuiltValueNullFieldError.checkNotNull(
                  network, r'Wallet', 'network'),
              address: address,
              privateKey: privateKey,
              tokenBalance: BuiltValueNullFieldError.checkNotNull(
                  tokenBalance, r'Wallet', 'tokenBalance'),
              ethBalance: BuiltValueNullFieldError.checkNotNull(
                  ethBalance, r'Wallet', 'ethBalance'),
              loading: BuiltValueNullFieldError.checkNotNull(
                  loading, r'Wallet', 'loading'),
              errors: _errors?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Wallet', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
