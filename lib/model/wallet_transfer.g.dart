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
  final String? transactionId;
  @override
  final bool loading;

  factory _$WalletTransfer([void Function(WalletTransferBuilder)? updates]) =>
      (new WalletTransferBuilder()..update(updates))._build();

  _$WalletTransfer._(
      {this.errors,
      required this.status,
      this.transactionId,
      required this.loading})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, r'WalletTransfer', 'status');
    BuiltValueNullFieldError.checkNotNull(
        loading, r'WalletTransfer', 'loading');
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
        transactionId == other.transactionId &&
        loading == other.loading;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, loading.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletTransfer')
          ..add('errors', errors)
          ..add('status', status)
          ..add('transactionId', transactionId)
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

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  bool? _loading;
  bool? get loading => _$this._loading;
  set loading(bool? loading) => _$this._loading = loading;

  WalletTransferBuilder();

  WalletTransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _errors = $v.errors?.toBuilder();
      _status = $v.status;
      _transactionId = $v.transactionId;
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
  WalletTransfer build() => _build();

  _$WalletTransfer _build() {
    _$WalletTransfer _$result;
    try {
      _$result = _$v ??
          new _$WalletTransfer._(
              errors: _errors?.build(),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'WalletTransfer', 'status'),
              transactionId: transactionId,
              loading: BuiltValueNullFieldError.checkNotNull(
                  loading, r'WalletTransfer', 'loading'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WalletTransfer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
