import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../app_config.dart';

part 'network_type.g.dart';

class NetworkType extends EnumClass {
  const NetworkType._(String name) : super(name);

  static Serializer<NetworkType> get serializer => _$networkTypeSerializer;

  static const NetworkType Local = _$Local;
  static const NetworkType Ethereum = _$Ethereum;
  static const NetworkType Matic = _$Matic;
  static const NetworkType BSC = _$BSC;

  static BuiltSet<NetworkType> get values => _$values;

  static List<NetworkType> get enabledValues =>
      values.where((r) => r.config.enabled).toList();

  static NetworkType valueOf(String name) => _$valuesOf(name);

  AppConfigParams get config => AppConfig.networks[NetworkType.valueOf(name)]!;
}
