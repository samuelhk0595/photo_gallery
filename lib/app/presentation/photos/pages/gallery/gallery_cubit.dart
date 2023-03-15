import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'package:photo_gallery/app/presentation/photos/pages/photo_details/photo_details_page.dart';
import 'package:photo_gallery/app/presentation/photos/stores/home_store.dart';
import 'package:photo_gallery/app/routes/app_navigator.dart';
import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GetPhotosUseCase getPhotosFromJsonPlaceHolder;
  final GetPhotosUseCase getPhotosFromPexels;
  final HomeStore homeStore;
  final AppNaviagator naviagator;

  GalleryCubit({
    required this.homeStore,
    required this.getPhotosFromJsonPlaceHolder,
    required this.getPhotosFromPexels,
    required this.naviagator,
  }) : super(GalleryIdleState());

  Future<void> getPhotos() async {
    emit(GalleryLoadingState());
    final response = await getPhotosFromJsonPlaceHolder();
    response.fold((failure) {
      emit(GalleryFailureState(failure.message));
    }, (photos) {
      homeStore.photos = photos;
      emit(GallerySuccessState(photos: photos));
    });
  }

  void selectPhoto(int photoId) {
    homeStore.selectedPhotos.add(photoId);
    emit(GallerySuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

  void unselectPhoto(int photoId) {
    homeStore.selectedPhotos.remove(photoId);
    emit(GallerySuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

  void onPhotoTap(PhotoEntity photo) {
    if (homeStore.isOnSelectionMode) {
      if (homeStore.selectedPhotos.contains(photo.id)) {
        unselectPhoto(photo.id);
      } else {
        selectPhoto(photo.id);
      }
    } else {
      naviagator.pushNamed(PhotoDetailsPage.routeName, arguments: [photo]);
    }
  }

  void onPhotoLongPress(int photoId) {
    if (homeStore.isOnSelectionMode) {
    } else {
      selectPhoto(photoId);
    }
  }

  void clearSelection() {
    homeStore.selectedPhotos.clear();
    emit(GallerySuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

  void viewAllSelectedPhotos() {
    List<PhotoEntity> photos = homeStore.photos
        .where((photo) => homeStore.selectedPhotos.contains(photo.id))
        .toList();

    naviagator.pushNamed(PhotoDetailsPage.routeName, arguments: photos);
  }
}
