import 'package:dartz/dartz.dart';
import 'package:photo_gallery/app/core/failure.dart';
import 'package:photo_gallery/app/domain/json_placeholder/entities/photo_entity.dart';

abstract class JsonPlaceholderRepository {
  Future<Either<Failure, List<PhotoEntity>>> getPhotos();
}
