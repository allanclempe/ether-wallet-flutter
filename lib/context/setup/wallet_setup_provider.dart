import 'package:etherwallet/context/setup/wallet_setup_handler.dart';
import 'package:etherwallet/context/setup/wallet_setup_state.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:provider/provider.dart';

import '../hook_provider.dart';

class WalletSetupProvider extends ContextProviderWidget<WalletSetupHandler> {
  const WalletSetupProvider(
      {Widget? child, HookWidgetBuilder<WalletSetupHandler>? builder, Key? key})
      : super(child: child, builder: builder, key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<WalletSetup, WalletSetupAction>(reducer,
        initialState: WalletSetup(), initialAction: WalletSetupInit());

    final addressService = Provider.of<AddressService>(context);
    final handler = useMemoized(
      () => WalletSetupHandler(store, addressService),
      [addressService, store],
    );

    return provide(context, handler);
  }
}

WalletSetupHandler useWalletSetup(BuildContext context) =>
    Provider.of<WalletSetupHandler>(context);
