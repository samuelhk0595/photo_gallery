import 'package:dio/dio.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

import '../../contants/photo_costants.dart';
import '../../failures/cant_get_photos_failure.dart';
import '../../models/photo_model.dart';
import '../photo_datasource.dart';

class PexelsDataSource implements PhotoDatasource {
  final Dio dio;

  PexelsDataSource(this.dio) {
    dio.options.baseUrl = PhotoConstants.pexelsBaseUrl;
    dio.options.headers['Authorization'] = PhotoConstants.pexelsApiKey;
  }

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    final response =
        await dio.get('${PhotoConstants.pexelsCuratedEndpoint}?per_page=80');
    if (response.statusCode == 200 && response.data != null) {
      return response.data!['photos']
          .map<PhotoEntity>((json) => PhotoModel.fromPexels(json))
          .toList();
    }
    throw CantGetPhotosFailure();
  }
}
