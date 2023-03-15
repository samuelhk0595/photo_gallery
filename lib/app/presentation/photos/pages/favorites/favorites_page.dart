import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';
import 'package:photo_gallery/app/presentation/photos/pages/favorites/favorites_cubit.dart';

class FavoritesPage extends StatefulWidget {
  static const String routeName = '/FavoritesPage';
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final cubit = GetIt.I.get<FavoritesCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.getFavoritePhotos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PhotoEntity>>(
        stream: cubit.stream,
        initialData: const [],
        builder: (context, snapshot) {
          final photos = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: Builder(builder: (context) {
              if (photos.isEmpty) return const Center(child: Text('You did\'t favorited any photos yet'));
              return ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos.elementAt(index);

                    return GestureDetector(
                      onTap: ()=> cubit.openPhoto(photo),
                      child: Card(
                        child: SizedBox(
                            height: 200,
                            child: Hero(
                              tag: photo.id,
                              child: Image.network(
                                photo.thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    );
                
                  });
            }),
          );
        });
  }
}
