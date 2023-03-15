import 'package:flutter/material.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class PhotoDetailsPage extends StatefulWidget {
  static const String routeName = '/PhotoDetailsPage';
  const PhotoDetailsPage({super.key, required this.photos});

  final List<PhotoEntity> photos;
  @override
  State<PhotoDetailsPage> createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: PageView.builder(
          itemCount: widget.photos.length,
          itemBuilder: (context, index) {
            final photo = widget.photos.elementAt(index);
            return Image.network(photo.url);
          }),
    );
  }
}
