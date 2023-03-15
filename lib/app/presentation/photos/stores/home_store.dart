import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class HomeStore {
  List<PhotoEntity> photos = [];
  final selectedPhotos = <int>[];

  bool get isOnSelectionMode => selectedPhotos.isNotEmpty;
}
