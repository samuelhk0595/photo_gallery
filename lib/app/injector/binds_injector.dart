import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/data/photo/datasources/impl/json_place_holder_datasource.dart';
import 'package:photo_gallery/app/data/photo/repositories/photo_repository_impl.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'package:photo_gallery/app/injector/injector.dart';
import 'package:photo_gallery/app/presentation/photos/pages/home/home_cubit.dart';

class BindsInjector extends Injector {
  BindsInjector(super.getItInstance);

  @override
  void core(GetIt i) {
    i.registerFactory(() => Dio());
  }

  @override
  void datasources(GetIt i) {
    i.registerFactory(() => JsonPlaceholderDataSource(i.get<Dio>()));
  }

  @override
  void repositories(GetIt i) {
    i.registerFactory(
        () => PhotoRespositoryImpl(i.get<JsonPlaceholderDataSource>()));
  }

  @override
  void useCases(GetIt i) {
    i.registerFactory(() => GetPhotosUseCase(i.get<PhotoRespositoryImpl>()));
  }

  @override
  void cubits(GetIt i) {
    i.registerFactory(
        () => HomeCubit(getPhotosUseCase: i.get<GetPhotosUseCase>()));
  }
}
