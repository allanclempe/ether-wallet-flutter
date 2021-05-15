import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef OnScanned = void Function(String? address);

class QRCodeReaderPage extends StatefulWidget {
  const QRCodeReaderPage({
    Key? key,
    required this.title,
    this.onScanned,
    this.closeWhenScanned = true,
  }) : super(key: key);

  final OnScanned? onScanned;
  final bool closeWhenScanned;
  final String title;

  @override
  State<StatefulWidget> createState() => _QRCodeReaderPageState();
}

class _QRCodeReaderPageState extends State<QRCodeReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  static final RegExp _basicAddress =
      RegExp(r'^(0x)?[0-9a-f]{40}', caseSensitive: false);

  StreamSubscription? _subscription;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea,
                )),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    _subscription = controller.scannedDataStream.listen((scanData) {
      // metamask qrcode adds "ethereum:" in front of the address.
      final address = scanData.code.replaceAll('ethereum:', '');

      if (!_basicAddress.hasMatch(address)) {
        return;
      }

      widget.onScanned!(address);

      if (widget.closeWhenScanned) {
        _subscription?.cancel();

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
