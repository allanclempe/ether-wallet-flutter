// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NetworkType _$Local = const NetworkType._('Local');
const NetworkType _$Ethereum = const NetworkType._('Ethereum');
const NetworkType _$Matic = const NetworkType._('Matic');
const NetworkType _$BSC = const NetworkType._('BSC');

NetworkType _$valuesOf(String name) {
  switch (name) {
    case 'Local':
      return _$Local;
    case 'Ethereum':
      return _$Ethereum;
    case 'Matic':
      return _$Matic;
    case 'BSC':
      return _$BSC;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NetworkType> _$values =
    new BuiltSet<NetworkType>(const <NetworkType>[
  _$Local,
  _$Ethereum,
  _$Matic,
  _$BSC,
]);

Serializer<NetworkType> _$networkTypeSerializer = new _$NetworkTypeSerializer();

class _$NetworkTypeSerializer implements PrimitiveSerializer<NetworkType> {
  @override
  final Iterable<Type> types = const <Type>[NetworkType];
  @override
  final String wireName = 'NetworkType';

  @override
  Object serialize(Serializers serializers, NetworkType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NetworkType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NetworkType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
