// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transfer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletTransfer extends WalletTransfer {
  @override
  final BuiltList<String>? errors;
  @override
  final WalletTransferStatus status;
  @override
  final bool loading;

  factory _$WalletTransfer([void Function(WalletTransferBuilder)? updates]) =>
      (new WalletTransferBuilder()..update(updates)).build();

  _$WalletTransfer._({this.errors, required this.status, required this.loading})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, 'WalletTransfer', 'status');
    BuiltValueNullFieldError.checkNotNull(loading, 'WalletTransfer', 'loading');
  }

  @override
  WalletTransfer rebuild(void Function(WalletTransferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletTransferBuilder toBuilder() =>
      new WalletTransferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletTransfer &&
        errors == other.errors &&
        status == other.status &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, errors.hashCode), status.hashCode), loading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WalletTransfer')
          ..add('errors', errors)
          ..add('status', status)
          ..add('loading', loading))
        .toString();
  }
}

class WalletTransferBuilder
    implements Builder<WalletTransfer, WalletTransferBuilder> {
  _$WalletTransfer? _$v;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors =>
      _$this._errors ??= new ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  WalletTransferStatus? _status;
  WalletTransferStatus? get status => _$this._status;
  set status(WalletTransferStatus? status) => _$this._status = status;

  bool? _loading;
  bool? get loading => _$this._loading;
  set loading(bool? loading) => _$this._loading = loading;

  WalletTransferBuilder();

  WalletTransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _errors = $v.errors?.toBuilder();
      _status = $v.status;
      _loading = $v.loading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletTransfer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WalletTransfer;
  }

  @override
  void update(void Function(WalletTransferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WalletTransfer build() {
    _$WalletTransfer _$result;
    try {
      _$result = _$v ??
          new _$WalletTransfer._(
              errors: _errors?.build(),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, 'WalletTransfer', 'status'),
              loading: BuiltValueNullFieldError.checkNotNull(
                  loading, 'WalletTransfer', 'loading'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WalletTransfer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
