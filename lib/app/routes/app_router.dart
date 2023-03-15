import 'package:flutter/material.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/presentation/photos/pages/favorites/favorites_page.dart';
import 'package:photo_gallery/app/presentation/photos/pages/gallery/gallery_page.dart';
import 'package:photo_gallery/app/presentation/photos/pages/photo_details/photo_details_page.dart';

class AppRouter {
  static String initialRoute = GalleryPage.routeName;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FavoritesPage.routeName:
        return MaterialPageRoute(builder: (context) => const FavoritesPage());

      case GalleryPage.routeName:
        return MaterialPageRoute(builder: (context) => const GalleryPage());

      case PhotoDetailsPage.routeName:
        return MaterialPageRoute(
            builder: (context) => PhotoDetailsPage(
                  photo: settings.arguments as PhotoEntity,
                ));
    }
  }
}
