import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeNetwork extends StatelessWidget {
  const ChangeNetwork(
      {Key? key,
      required this.currentValue,
      required this.onChange,
      this.loading = false})
      : super(key: key);

  final NetworkType currentValue;
  final bool loading;
  final Function(NetworkType network) onChange;

  @override
  Widget build(BuildContext context) {
    final networks = NetworkType.enabledValues;
    const itemHeight = 48.0;

    return ElevatedButton(
      child: Text(currentValue.config.label),
      onPressed: !loading
          ? () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: itemHeight * networks.length,
                    child: Column(
                      children: <Widget>[
                        for (var network in networks)
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize:
                                  const Size(double.infinity, itemHeight),
                            ),
                            onPressed: () {
                              onChange(network);
                              Navigator.pop(context);
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(network.config.label),
                                  if (network == currentValue) ...[
                                    const SizedBox(width: 10),
                                    const Icon(
                                      WalletIcons.check,
                                      size: 15,
                                    )
                                  ]
                                ]),
                          ),
                      ],
                    ),
                  );
                },
              );
            }
          : null,
    );
  }
}
