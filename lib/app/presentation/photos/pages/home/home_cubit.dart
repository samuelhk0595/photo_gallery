import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/domain/photo/use_cases/get_photos_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPhotosUseCase getPhotosUseCase;

  HomeCubit({required this.getPhotosUseCase}) : super(HomeIdleState());

  Future<void> getPhotos() async {
    emit(HomeLoadingState());
    final response = await getPhotosUseCase();
    response.fold((failure) {
      emit(HomeFailureState(failure.message));
    }, (photos) {
      emit(HomeSuccessState(photos));
    });
  }
}
