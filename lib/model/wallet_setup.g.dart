// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_setup.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletSetup extends WalletSetup {
  @override
  final String? mnemonic;
  @override
  final String? privateKey;
  @override
  final WalletCreateSteps step;
  @override
  final WalletSetupMethod method;
  @override
  final bool loading;
  @override
  final BuiltList<String>? errors;

  factory _$WalletSetup([void Function(WalletSetupBuilder)? updates]) =>
      (new WalletSetupBuilder()..update(updates)).build();

  _$WalletSetup._(
      {this.mnemonic,
      this.privateKey,
      required this.step,
      required this.method,
      required this.loading,
      this.errors})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(step, 'WalletSetup', 'step');
    BuiltValueNullFieldError.checkNotNull(method, 'WalletSetup', 'method');
    BuiltValueNullFieldError.checkNotNull(loading, 'WalletSetup', 'loading');
  }

  @override
  WalletSetup rebuild(void Function(WalletSetupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletSetupBuilder toBuilder() => new WalletSetupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletSetup &&
        mnemonic == other.mnemonic &&
        privateKey == other.privateKey &&
        step == other.step &&
        method == other.method &&
        loading == other.loading &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, mnemonic.hashCode), privateKey.hashCode),
                    step.hashCode),
                method.hashCode),
            loading.hashCode),
        errors.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WalletSetup')
          ..add('mnemonic', mnemonic)
          ..add('privateKey', privateKey)
          ..add('step', step)
          ..add('method', method)
          ..add('loading', loading)
          ..add('errors', errors))
        .toString();
  }
}

class WalletSetupBuilder implements Builder<WalletSetup, WalletSetupBuilder> {
  _$WalletSetup? _$v;

  String? _mnemonic;
  String? get mnemonic => _$this._mnemonic;
  set mnemonic(String? mnemonic) => _$this._mnemonic = mnemonic;

  String? _privateKey;
  String? get privateKey => _$this._privateKey;
  set privateKey(String? privateKey) => _$this._privateKey = privateKey;

  WalletCreateSteps? _step;
  WalletCreateSteps? get step => _$this._step;
  set step(WalletCreateSteps? step) => _$this._step = step;

  WalletSetupMethod? _method;
  WalletSetupMethod? get method => _$this._method;
  set method(WalletSetupMethod? method) => _$this._method = method;

  bool? _loading;
  bool? get loading => _$this._loading;
  set loading(bool? loading) => _$this._loading = loading;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors =>
      _$this._errors ??= new ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  WalletSetupBuilder();

  WalletSetupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mnemonic = $v.mnemonic;
      _privateKey = $v.privateKey;
      _step = $v.step;
      _method = $v.method;
      _loading = $v.loading;
      _errors = $v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletSetup other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WalletSetup;
  }

  @override
  void update(void Function(WalletSetupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WalletSetup build() {
    _$WalletSetup _$result;
    try {
      _$result = _$v ??
          new _$WalletSetup._(
              mnemonic: mnemonic,
              privateKey: privateKey,
              step: BuiltValueNullFieldError.checkNotNull(
                  step, 'WalletSetup', 'step'),
              method: BuiltValueNullFieldError.checkNotNull(
                  method, 'WalletSetup', 'method'),
              loading: BuiltValueNullFieldError.checkNotNull(
                  loading, 'WalletSetup', 'loading'),
              errors: _errors?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WalletSetup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
