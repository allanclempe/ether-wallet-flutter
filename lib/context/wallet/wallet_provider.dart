import 'package:etherwallet/model/wallet.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../hook_provider.dart';
import 'wallet_handler.dart';
import 'wallet_state.dart';

class WalletProvider extends ContextProviderWidget<WalletHandler> {
  const WalletProvider(
      {Key? key, Widget? child, HookWidgetBuilder<WalletHandler>? builder})
      : super(child: child, builder: builder, key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<Wallet, WalletAction>(
      reducer,
      initialState: Wallet(),
      initialAction: WalletInit(),
    );

    final addressService = Provider.of<AddressService>(context);
    final contractServiceFactory = Provider.of<ContractLocator>(context);
    final configurationService = Provider.of<ConfigurationService>(context);
    final handler = useMemoized(
      () => WalletHandler(
        store,
        addressService,
        contractServiceFactory,
        configurationService,
      ),
      [addressService, store],
    );

    return provide(context, handler);
  }
}

WalletHandler useWallet(BuildContext context) =>
    Provider.of<WalletHandler>(context);
