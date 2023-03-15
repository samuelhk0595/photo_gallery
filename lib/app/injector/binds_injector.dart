import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/data/photo/contants/photo_costants.dart';
import 'package:photo_gallery/app/data/photo/datasources/impl/json_place_holder_datasource.dart';
import 'package:photo_gallery/app/data/photo/repositories/photo_repository_impl.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'package:photo_gallery/app/injector/injector.dart';
import 'package:photo_gallery/app/presentation/photos/pages/favorites/favorites_cubit.dart';
import 'package:photo_gallery/app/presentation/photos/pages/gallery/gallery_cubit.dart';
import 'package:photo_gallery/app/routes/app_navigator.dart';

import '../data/photo/datasources/impl/pexels_datasource.dart';
import '../presentation/photos/stores/gallery_store.dart';

class BindsInjector extends Injector {
  BindsInjector(super.getItInstance);

  @override
  void core(GetIt i) {
    i.registerFactory(() => Dio());
    i.registerSingleton(AppNavigator());
  }

  @override
  void datasources(GetIt i) {
    i.registerFactory(() => JsonPlaceholderDataSource(i.get<Dio>()));
    i.registerFactory(() => PexelsDataSource(i.get<Dio>()));
  }

  @override
  void repositories(GetIt i) {
    i.registerFactory(
        () => PhotoRespositoryImpl(i.get<JsonPlaceholderDataSource>()),
        instanceName: PhotoConstants.jsonPlaceHolderInstanceName);
    i.registerFactory(() => PhotoRespositoryImpl(i.get<PexelsDataSource>()),
        instanceName: PhotoConstants.pexelsInstanceName);
  }

  @override
  void stores(GetIt i) {
    i.registerSingleton(GalleryStore());
  }

  @override
  void useCases(GetIt i) {
    i.registerFactory(
        () => GetPhotosUseCase(i.get<PhotoRespositoryImpl>(
            instanceName: PhotoConstants.jsonPlaceHolderInstanceName)),
        instanceName: PhotoConstants.jsonPlaceHolderInstanceName);
    i.registerFactory(
        () => GetPhotosUseCase(i.get<PhotoRespositoryImpl>(
            instanceName: PhotoConstants.pexelsInstanceName)),
        instanceName: PhotoConstants.pexelsInstanceName);
  }

  @override
  void cubits(GetIt i) {
    i.registerFactory(() => GalleryCubit(
          getPhotosFromJsonPlaceHolder: i.get<GetPhotosUseCase>(
              instanceName: PhotoConstants.jsonPlaceHolderInstanceName),
          getPhotosFromPexels: i.get<GetPhotosUseCase>(
              instanceName: PhotoConstants.pexelsInstanceName),
          homeStore: i.get<GalleryStore>(),
          navigator: i.get<AppNavigator>(),
        ));

    i.registerFactory(() => FavoritesCubit(
        homeStore: i.get<GalleryStore>(), navigator: i.get<AppNavigator>()));
  }
}
