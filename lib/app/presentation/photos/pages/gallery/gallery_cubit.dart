import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'package:photo_gallery/app/presentation/photos/pages/favorites/favorites_page.dart';
import 'package:photo_gallery/app/presentation/photos/pages/photo_details/photo_details_page.dart';
import 'package:photo_gallery/app/presentation/photos/stores/gallery_store.dart';
import 'package:photo_gallery/app/routes/app_navigator.dart';
import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GetPhotosUseCase getPhotosFromJsonPlaceHolder;
  final GetPhotosUseCase getPhotosFromPexels;
  final GalleryStore homeStore;
  final AppNavigator navigator;

  GalleryCubit({
    required this.homeStore,
    required this.getPhotosFromJsonPlaceHolder,
    required this.getPhotosFromPexels,
    required this.navigator,
  }) : super(GalleryIdleState());

  Future<void> getPhotos() async {
    if (homeStore.photos.isEmpty) emit(GalleryLoadingState());
    // homeStore.photos.clear();
    homeStore.selectedPhotos.clear();
    final response = homeStore.lookPrettier
        ? await getPhotosFromPexels()
        : await getPhotosFromJsonPlaceHolder();
    response.fold((failure) {
      emit(GalleryFailureState(failure.message));
    }, (photos) {
      homeStore.photos = photos;
      emit(GallerySuccessState(
        photos: photos,
        lookPrettier: homeStore.lookPrettier,
      ));
    });
  }

  void addPhotoToFavorites(int photoId) {
    homeStore.selectedPhotos.add(photoId);
    emit(GallerySuccessState(
        photos: homeStore.photos,
        selectedPhotos: homeStore.selectedPhotos,
        lookPrettier: homeStore.lookPrettier));
  }

  void removePhotoFromFavorites(int photoId) {
    homeStore.selectedPhotos.remove(photoId);
    emit(GallerySuccessState(
        photos: homeStore.photos,
        selectedPhotos: homeStore.selectedPhotos,
        lookPrettier: homeStore.lookPrettier));
  }

  void onPhotoTap(PhotoEntity photo) {
    if (homeStore.selectedPhotos.contains(photo.id)) {
      removePhotoFromFavorites(photo.id);
    } else {
      addPhotoToFavorites(photo.id);
    }
    // naviagator.pushNamed(PhotoDetailsPage.routeName, arguments: [photo]);
  }

  void onSwitchChange(bool value) {
    homeStore.lookPrettier = value;
    getPhotos();
  }

  void goToFavoritesPage() {
    navigator.pushNamed(FavoritesPage.routeName);
  }

  void viewAllSelectedPhotos() {
    List<PhotoEntity> photos = homeStore.photos
        .where((photo) => homeStore.selectedPhotos.contains(photo.id))
        .toList();

    navigator.pushNamed(PhotoDetailsPage.routeName, arguments: photos);
  }
}
