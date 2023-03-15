import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/presentation/photos/pages/gallery/gallery_cubit.dart';
import 'package:photo_gallery/app/presentation/photos/widgets/photo_grid_tile.dart';

import '../../widgets/favorites_counter.dart';
import 'gallery_state.dart';

class GalleryPage extends StatefulWidget {
  static const String routeName = '/GalleryPage';
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with SingleTickerProviderStateMixin {
  final cubit = GetIt.I.get<GalleryCubit>();
  late final AnimationController animationController;
  late final Animation<double> aspectRatioAnimation;
  late final Animation<double> borderRadiusAnimation;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    aspectRatioAnimation = Tween<double>(begin: 1, end: 0.7).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));
    borderRadiusAnimation = Tween<double>(begin: 0, end: 18).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    cubit.getPhotos();
  }

  void switchAnimation(bool lookPrettier) {
    if (lookPrettier) {
      scrollController.animateTo(100,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
      animationController.forward();
    } else {
      scrollController.animateTo(100,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);

      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GalleryState>(
      stream: cubit.stream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        return Scaffold(
          body: Builder(builder: (context) {
            if (state is GalleryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GalleryFailureState) {
              return Center(child: Text(state.message));
            }

            if (state is GallerySuccessState) {
              return RefreshIndicator(
                onRefresh: cubit.getPhotos,
                child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, snapshot) {
                      return CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverAppBar(
                              elevation: 0,
                              floating: true,
                              backgroundColor: Colors.white,
                              title: Text(
                                state.lookPrettier
                                    ? 'Pexels Gallery'
                                    : 'JsonPlaceHolder Gallery',
                              ),
                              actions: [
                                buildFavoritesCounter(state),
                                const SizedBox(width: 20),
                              ],
                              bottom: PreferredSize(
                                  preferredSize: const Size(300, 50),
                                  child: Row(
                                    children: [
                                      Switch(
                                          value: state.lookPrettier,
                                          onChanged: (value) {
                                            cubit.onSwitchChange(value);
                                            switchAnimation(value);
                                          }),
                                      const Text(
                                          'Make everything look prettier!'),
                                    ],
                                  ))),
                          SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        aspectRatioAnimation.value,
                                    crossAxisCount: 2),
                            itemCount: state.photos.length,
                            itemBuilder: (context, index) {
                              final photo = state.photos.elementAt(index);
                              final isSelected =
                                  state.selectedPhotos.contains(photo.id);

                              return PhotoGridTile(
                                borderRadius: borderRadiusAnimation.value,
                                isFavorite: isSelected,
                                photo: photo,
                                onTap: () => cubit.onPhotoTap(photo),
                              );
                            },
                          )
                        ],
                      );
                    }),
              );
            }
            return const Center(child: Text('Wait...'));
          }),
        );
      },
    );
  }

  FavoritesCounter buildFavoritesCounter(GalleryState? state) {
    int count = 0;
    if (state is GallerySuccessState) {
      count = state.selectedPhotos.length;
    }
    return FavoritesCounter(count: count, onTap: cubit.goToFavoritesPage);
  }
}
