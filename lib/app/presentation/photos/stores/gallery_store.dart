import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class GalleryStore {
  List<PhotoEntity> photos = [];
  final selectedPhotos = <int>[];
  bool lookPrettier = false;
}
