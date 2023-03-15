import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/presentation/photos/pages/photo_details/photo_details_page.dart';
import 'package:photo_gallery/app/presentation/photos/stores/home_store.dart';
import 'package:photo_gallery/app/routes/app_navigator.dart';

import '../../../../domain/photo/entities/photo_entity.dart';

class FavoritesCubit extends Cubit<List<PhotoEntity>> {
  final HomeStore homeStore;
  final AppNavigator navigator;

  FavoritesCubit({
    required this.navigator,
    required this.homeStore,
  }) : super([]);

  void getFavoritePhotos() {
    final photos = <PhotoEntity>[];

    for (final photo in homeStore.photos) {
      if (homeStore.selectedPhotos.contains(photo.id)) {
        photos.add(photo);
      }
    }

    emit(photos);
  }

  void openPhoto(PhotoEntity photo) {
    navigator.pushNamed(PhotoDetailsPage.routeName,arguments: photo);
  }
}
