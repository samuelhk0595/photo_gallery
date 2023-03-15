import 'package:dartz/dartz.dart';
import 'package:photo_gallery/app/core/failure.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoEntity>>> getPhotos();
}
