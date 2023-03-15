import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'package:photo_gallery/app/presentation/photos/stores/home_store.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPhotosUseCase getPhotosUseCase;
  final HomeStore homeStore;
  final AppNaviagator naviagator;

  HomeCubit({
    required this.homeStore,
    required this.getPhotosUseCase,
    required this.naviagator,
  }) : super(HomeIdleState());

  Future<void> getPhotos() async {
    emit(HomeLoadingState());
    final response = await getPhotosUseCase();
    response.fold((failure) {
      emit(HomeFailureState(failure.message));
    }, (photos) {
      homeStore.photos = photos;
      emit(HomeSuccessState(photos: photos));
    });
  }

  void selectPhoto(int photoId) {
    homeStore.selectedPhotos.add(photoId);
    emit(HomeSuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

  void unselectPhoto(int photoId) {
    homeStore.selectedPhotos.remove(photoId);
    emit(HomeSuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

  void onPhotoTap(int photoId) {
    if (homeStore.isOnSelectionMode) {
      if (homeStore.selectedPhotos.contains(photoId)) {
        unselectPhoto(photoId);
      } else {
        selectPhoto(photoId);
      }
    } else {
      //Navigate to details page
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
    emit(HomeSuccessState(
      photos: homeStore.photos,
      selectedPhotos: homeStore.selectedPhotos,
    ));
  }

}
