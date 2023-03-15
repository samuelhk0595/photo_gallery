import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

abstract class HomeState {}

class HomeIdleState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFailureState extends HomeState {
  final String message;

  HomeFailureState(this.message);
}

class HomeSuccessState extends HomeState {
  final List<PhotoEntity> photos;
  final List<int> selectedPhotos;

  HomeSuccessState({
    required this.photos,
    this.selectedPhotos = const [],
  });
}
