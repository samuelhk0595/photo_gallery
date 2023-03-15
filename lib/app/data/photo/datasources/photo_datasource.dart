import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

abstract class PhotoDatasource {
  Future<List<PhotoEntity>> getPhotos();
}
