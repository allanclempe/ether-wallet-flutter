import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Your transaction is being processed',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 48.0),
        SpinKitWanderingCubes(color: Colors.blue),
        SizedBox(height: 48.0),
      ],
    );
  }
}
