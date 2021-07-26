import 'package:etherwallet/context/transfer/wallet_transfer_handler.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_state.dart';
import 'package:etherwallet/model/wallet_transfer.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:provider/provider.dart';

import '../hook_provider.dart';

class WalletTransferProvider
    extends ContextProviderWidget<WalletTransferHandler> {
  const WalletTransferProvider(
      {Widget? child,
      HookWidgetBuilder<WalletTransferHandler>? builder,
      Key? key})
      : super(child: child, builder: builder, key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<WalletTransfer, WalletTransferAction>(reducer,
        initialState: WalletTransfer(), initialAction: WalletTransferInit());

    final contractService = Provider.of<ContractLocator>(context);
    final configurationService = Provider.of<ConfigurationService>(context);
    final handler = useMemoized(
      () => WalletTransferHandler(store, contractService, configurationService),
      [contractService, store],
    );

    return provide(context, handler);
  }
}

WalletTransferHandler useWalletTransfer(BuildContext context) =>
    Provider.of<WalletTransferHandler>(context);
