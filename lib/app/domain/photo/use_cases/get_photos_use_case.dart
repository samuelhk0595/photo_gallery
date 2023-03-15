import 'package:dartz/dartz.dart';
import 'package:photo_gallery/app/core/failure.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/domain/photo/repositories/photo_repository.dart';

class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Either<Failure, List<PhotoEntity>>> call() {
    return repository.getPhotos();
  }
}
