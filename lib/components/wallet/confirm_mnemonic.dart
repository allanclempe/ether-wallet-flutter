import 'dart:ui';

import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ConfirmMnemonic extends HookWidget {
  ConfirmMnemonic(
      {this.mnemonic, this.errors, this.onConfirm, this.onGenerateNew});

  final String mnemonic;
  final List<String> errors;
  final Function onConfirm;
  final Function onGenerateNew;

  final darkGrey = Color(0xFF1C1C1C);
  final LinearGradient button_gradient =
      LinearGradient(colors: [Color(0xFF0779E4), Color(0xFF1DD3BD)]);

  @override
  Widget build(BuildContext context) {
    var mnemonicController = useTextEditingController();
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Please confirm your Seed Phrase',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 5),
                child: Text('Seed Phrase', style: TextStyle(fontSize: 12),),
              ),
              Container(
                child: PaperForm(
                  padding: 0,
                  actionButtons: <Widget>[
                    Expanded(
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.transparent,
                          borderSide: BorderSide(color: Colors.black),
                          highlightedBorderColor: Colors.black,
                          child: Text(
                            "BACK",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: this.onGenerateNew,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
                            "CONFIRM",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: this.onConfirm != null
                              ? () =>
                              this.onConfirm(mnemonicController.value.text)
                              : null,
                        ),
                      ),
                    ),
                  ],
                  children: <Widget>[
                    PaperValidationSummary(this.errors),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkGrey,
                      ),
                      child: PaperInput(
                        hintText: 'Confirm your seed',
                        maxLines: 2,
                        controller: mnemonicController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
