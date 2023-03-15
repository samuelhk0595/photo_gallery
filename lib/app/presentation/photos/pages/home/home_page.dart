import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_gallery/app/presentation/photos/pages/home/home_cubit.dart';

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
        appBar: AppBar(title: const Text('Home')),
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
              return RefreshIndicator(
                onRefresh: cubit.getPhotos,
                child: ListView.builder(
                    itemCount: state.photos.length,
                    itemBuilder: (context, index) {
                      final photo = state.photos.elementAt(index);
                      return ListTile(
                        title: Text(photo.url),
                      );
                    }),
              );
            }

            return const Center(child: Text('Wait...'));
          },
        ));
  }
}
