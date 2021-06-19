import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'network_type.g.dart';

class NetworkType extends EnumClass {
  const NetworkType._(String name) : super(name);

  static Serializer<NetworkType> get serializer => _$networkTypeSerializer;

  static const NetworkType Ethereum = _$Ethereum;
  static const NetworkType Matic = _$Matic;
  static const NetworkType BSC = _$BSC;

  static BuiltSet<NetworkType> get values => _$values;

  static NetworkType valueOf(String name) => _$valuesOf(name);
}
