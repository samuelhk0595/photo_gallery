import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

abstract class GalleryState {}

class GalleryIdleState extends GalleryState {}

class GalleryLoadingState extends GalleryState {}

class GalleryFailureState extends GalleryState {
  final String message;

  GalleryFailureState(this.message);
}

class GallerySuccessState extends GalleryState {
  final List<PhotoEntity> photos;
  final List<int> selectedPhotos;

  GallerySuccessState({
    required this.photos,
    this.selectedPhotos = const [],
  });
}
