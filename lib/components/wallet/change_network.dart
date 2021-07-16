import 'package:etherwallet/model/network_type.dart';
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

    return ElevatedButton(
      child: Text(currentValue.toString()),
      onPressed: !loading
          ? () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 48.0 * networks.length,
                    child: Column(
                      children: <Widget>[
                        for (var network in networks)
                          RawMaterialButton(
                            onPressed: () {
                              onChange(network);
                              Navigator.pop(context);
                            },
                            child: Text(network.name),
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
