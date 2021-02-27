import 'package:etherwallet/context/setup/wallet_setup_handler.dart';
import 'package:etherwallet/context/setup/wallet_setup_state.dart';
import 'package:etherwallet/model/wallet_setup.dart';
import 'package:etherwallet/service/address_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:provider/provider.dart' as p;

import '../hook_provider.dart';

class WalletSetupProvider extends ContextProviderWidget<WalletSetupHandler> {
  WalletSetupProvider(
      {Widget child, HookWidgetBuilder<WalletSetupHandler> builder})
      : super(child: child, builder: builder);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<WalletSetup, WalletSetupAction>(reducer,
        initialState: WalletSetup());

    final addressService = p.Provider.of<AddressService>(context);
    final handler = useMemoized(
      () => WalletSetupHandler(store, addressService),
      [addressService, store],
    );

    return provide(context, handler);
  }
}

WalletSetupHandler useWalletSetup(BuildContext context) {
  var handler = p.Provider.of<WalletSetupHandler>(context);

  return handler;
}
