import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProcessingTransactionPage extends StatelessWidget {
  ProcessingTransactionPage({this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.send),
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your transaction is being processed',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48.0),
              SpinKitWanderingCubes(color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
