import 'package:flutter/material.dart';

T getRouteArgs<T>(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments;

  if (args == null) {
    throw Exception('Route argument is required.');
  }

  return ModalRoute.of(context)!.settings.arguments as T;
}
