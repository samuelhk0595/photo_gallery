import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/injector/binds_injector.dart';
import 'package:photo_gallery/app/routes/app_navigator.dart';
import 'package:photo_gallery/app/routes/app_router.dart';

void main() {
  BindsInjector(GetIt.instance).registerAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: GetIt.I.get<AppNaviagator>().navigatorKey,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
