import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/presentation/photos/pages/home/home_cubit.dart';
import 'package:photo_gallery/app/presentation/photos/widgets/photo_grid_tile.dart';

import 'home_state.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = GetIt.I.get<HomeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            StreamBuilder<HomeState>(
                stream: cubit.stream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state is HomeSuccessState && state.selectedPhotos.isNotEmpty) {
                    return TextButton(
                        onPressed: cubit.clearSelection,
                        child: const Text(
                          'Clear selecion',
                          style: TextStyle(color: Colors.white),
                        ));
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
        body: StreamBuilder<HomeState>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeFailureState) {
              return Center(child: Text(state.message));
            }

            if (state is HomeSuccessState) {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: cubit.getPhotos,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 40),
                      itemCount: state.photos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final photo = state.photos.elementAt(index);
                        final isSelected =
                            state.selectedPhotos.contains(photo.id);

                        return PhotoGridTile(
                          isSelected: isSelected,
                          photo: photo,
                          onLongPress: () => cubit.onPhotoLongPress(photo.id),
                          onTap: () => cubit.onPhotoTap(photo),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Offstage(
                      offstage: state.selectedPhotos.isEmpty,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${state.selectedPhotos.length} selected items'),
                            TextButton(
                                onPressed: cubit.viewAllSelectedPhotos,
                                child: const Text(
                                  'View all',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('Wait...'));
          },
        ));
  }
}
