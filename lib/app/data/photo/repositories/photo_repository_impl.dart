import 'package:photo_gallery/app/common/uknown_failure.dart';
import 'package:photo_gallery/app/data/photo/datasources/photo_datasource.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_gallery/app/domain/photo/repositories/photo_repository.dart';

class PhotoRespositoryImpl extends PhotoRepository {
  final PhotoDatasource datasource;

  PhotoRespositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotos() async {
    try {
      final photos = await datasource.getPhotos();
      return Right(photos);
    } catch (error) {
      if (error is Failure) return Left(error);
      return Left(UnknownFailure());
    }
  }
}
