import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DisplayMnemonic extends HookWidget {
  DisplayMnemonic({this.mnemonic, this.onNext});

  final String mnemonic;
  final Function onNext;
  final darkGrey = Color(0xFF1C1C1C);
  final borderColor = Color(0xFF282828);

  final LinearGradient button_gradient =
      LinearGradient(colors: [Color(0xFF0779E4), Color(0xFF1DD3BD)]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Get a piece of papper, write down your seed phrase and keep it safe. This is the only way to recover your funds.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5),
                child: Text(
                  'Seed Phrase',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: darkGrey),
                child: Text(
                  this.mnemonic,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 15),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: button_gradient,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent,
                        child: Text(
                          "COPY",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                              new ClipboardData(text: this.mnemonic));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: darkGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlineButton(
                        highlightedBorderColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent,
                        borderSide: BorderSide(color: Colors.black),
                        child: Text(
                          "NEXT",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: this.onNext,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
