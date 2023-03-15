import 'package:flutter/material.dart';
import 'package:photo_gallery/app/presentation/photos/pages/home/home_page.dart';

class AppRouter {
  static String initialRoute = HomePage.routeName;

 static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
