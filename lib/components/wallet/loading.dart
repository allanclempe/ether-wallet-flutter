import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.extra}) : super(key: key);

  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your transaction is being processed',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),
            const SpinKitWanderingCubes(color: Colors.blue),
            const SizedBox(height: 48.0),
            if (extra != null) extra!,
          ],
        ),
      ),
    );
  }
}
