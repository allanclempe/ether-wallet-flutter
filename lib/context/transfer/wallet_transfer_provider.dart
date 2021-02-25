import 'package:etherwallet/context/transfer/wallet_transfer_handler.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_state.dart';
import 'package:etherwallet/model/wallet_transfer.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:provider/provider.dart' as p;

import '../hook_provider.dart';

class WalletTransferProvider
    extends ContextProviderWidget<WalletTransferHandler> {
  WalletTransferProvider(
      {Widget child, HookWidgetBuilder<WalletTransferHandler> builder})
      : super(child: child, builder: builder);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<WalletTransfer, WalletTransferAction>(reducer,
        initialState: WalletTransfer());

    final contractService = p.Provider.of<ContractService>(context);
    final configurationService = p.Provider.of<ConfigurationService>(context);
    final handler = useMemoized(
      () => WalletTransferHandler(store, contractService, configurationService),
      [contractService, store],
    );

    return provide(context, handler);
  }
}

WalletTransferHandler useWalletTransfer(BuildContext context) {
  var handler = p.Provider.of<WalletTransferHandler>(context);

  return handler;
}
