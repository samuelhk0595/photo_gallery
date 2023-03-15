import 'package:flutter/material.dart';

class AppNaviagator {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<Object?>? pushNamed<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  void pop<T>() {
    return navigatorKey.currentState?.pop<T>();
  }
}
