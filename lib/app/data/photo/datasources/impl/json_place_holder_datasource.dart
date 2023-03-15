import 'package:dio/dio.dart';
import 'package:photo_gallery/app/data/photo/contants/photo_costants.dart';
import 'package:photo_gallery/app/data/photo/datasources/photo_datasource.dart';
import 'package:photo_gallery/app/data/photo/failures/cant_get_photos_failure.dart';
import 'package:photo_gallery/app/data/photo/models/photo_model.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class JsonPlaceholderDataSource implements PhotoDatasource {
  final Dio dio;

  JsonPlaceholderDataSource(this.dio) {
    dio.options.baseUrl = PhotoConstants.jsonPlaceHolderBaseUrl;
  }

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    final response =
        await dio.get<List>(PhotoConstants.jsonPlaceHolderPhotosEndpoint);
    if (response.statusCode == 200 && response.data != null) {
      return response.data!
          .map<PhotoEntity>((json) => PhotoModel.fromJsonPlaceHolder(json))
          .toList();
    }
    throw CantGetPhotosFailure();
  }
}
