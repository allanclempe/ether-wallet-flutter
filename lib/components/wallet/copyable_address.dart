import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CopyableAddress extends StatelessWidget {
  const CopyableAddress({Key? key, required this.address}) : super(key: key);

  final String? address;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(address ?? ''),
          const SizedBox(height: 10),
          CopyButton(
            text: const Text('Copy address'),
            value: address,
          ),
          if (address != null &&
              (mediaQuery.orientation == Orientation.portrait || kIsWeb))
            QrImage(
              data: address!,
              size: 150.0,
            ),
        ],
      ),
    );
  }
}
