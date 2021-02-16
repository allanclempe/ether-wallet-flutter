import 'dart:ui';

import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final LinearGradient button_gradient =
      LinearGradient(colors: [Color(0xFF0779E4), Color(0xFF1DD3BD)]);

  final darkGrey =  Color(0xFF1C1C1C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'You can either import an existing wallet or create a new wallet',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          color: darkGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent,
                        borderSide: BorderSide(color: Colors.black),
                        child: Text(
                          "Import wallet",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/import");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: button_gradient,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent,
                        child: Text(
                          "Create new wallet",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/create");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
