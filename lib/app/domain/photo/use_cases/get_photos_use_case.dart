import 'package:dartz/dartz.dart';
import 'package:photo_gallery/app/core/failure.dart';
import 'package:photo_gallery/app/domain/json_placeholder/entities/photo_entity.dart';
import 'package:photo_gallery/app/domain/json_placeholder/repositories/json_placeholder_repository.dart';

class GetPhotosUseCase {
  final JsonPlaceholderRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Either<Failure, List<PhotoEntity>>> call() {
    return repository.getPhotos();
  }
}
