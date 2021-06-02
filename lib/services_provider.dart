import 'package:etherwallet/app_config.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<SingleChildWidget>> createProviders() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final configurationService = ConfigurationService(sharedPrefs);

  final addressService = AddressService(configurationService);

  final contractServiceFactory = ContractServiceFactory(AppConfig());

  return [
    Provider.value(value: addressService),
    Provider.value(value: contractServiceFactory),
    Provider.value(value: configurationService),
  ];
}
