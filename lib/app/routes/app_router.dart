import 'package:flutter/material.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/presentation/photos/pages/home/home_page.dart';
import 'package:photo_gallery/app/presentation/photos/pages/photo_details/photo_details_page.dart';

class AppRouter {
  static String initialRoute = HomePage.routeName;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());

      case PhotoDetailsPage.routeName:
        return MaterialPageRoute(
            builder: (context) => PhotoDetailsPage(
                  photos: settings.arguments as List<PhotoEntity>,
                ));
    }
  }
}
