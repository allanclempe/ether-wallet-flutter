import 'dart:ui';

import 'package:etherwallet/app_config.dart';
import 'package:etherwallet/router.dart';
import 'package:etherwallet/services_provider.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  // bootstrapping;
  WidgetsFlutterBinding.ensureInitialized();
  final stores = await createProviders(AppConfig().params["ropsten"]);

  runApp(MainApp(stores));
}

class MainApp extends StatelessWidget {
  MainApp(this.stores);
  final List<SingleChildCloneableWidget> stores;
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: stores,
        child: MaterialApp(
          title: 'EtherWallet',
          initialRoute: '/',
          routes: getRoutes(context),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          theme: ThemeData(
            canvasColor: Colors.black,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
        ));
  }
}
