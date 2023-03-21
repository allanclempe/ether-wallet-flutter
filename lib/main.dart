import 'dart:io';

import 'package:etherwallet/context/wallet/wallet_provider.dart';
import 'package:etherwallet/router.dart';
import 'package:etherwallet/services_provider.dart';
import 'package:etherwallet/utils/http_override.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  // bootstrapping;

  if (kDebugMode) {
    // ingore http bad cert in debug
    // https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
    HttpOverrides.global = MyHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();

  const firebaseWebOptions = FirebaseOptions(
    apiKey: 'AIzaSyDWvJXaUYfFKdTHNxv5EA0iNEuCUAY7Nbo',
    authDomain: 'etherwallet-18c58.firebaseapp.com',
    databaseURL: 'https://etherwallet-18c58.firebaseio.com',
    projectId: 'etherwallet-18c58',
    storageBucket: 'etherwallet-18c58.appspot.com',
    messagingSenderId: '1087248227022',
    appId: '1:1087248227022:web:df8ff8ba4d302b361a4e9f',
    measurementId: 'G-V04M927HSD',
  );

  await Firebase.initializeApp(
    options: kIsWeb ? firebaseWebOptions : null,
  );

  final stores = await createProviders();

  runApp(MainApp(stores));
}

class MainApp extends StatelessWidget {
  const MainApp(this.stores, {Key? key}) : super(key: key);

  final List<SingleChildWidget> stores;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: stores,
      child: WalletProvider(
        builder: (context, store) => MaterialApp(
          title: 'Flutter App',
          initialRoute: '/',
          routes: getRoutes(context),
          navigatorObservers: [observer],
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
