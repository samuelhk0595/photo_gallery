import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class PhotoDetailsPage extends StatefulWidget {
  static const String routeName = '/PhotoDetailsPage';
  const PhotoDetailsPage({super.key, required this.photo});

  final PhotoEntity photo;
  @override
  State<PhotoDetailsPage> createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  final pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final screenSize =MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Builder(builder: (context) {
          return GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.network(
                    widget.photo.url,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.35),),
                Center(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Hero(
                      tag: widget.photo.id,
                      child: Image.network(
                        widget.photo.url,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: screenSize.width * 0.9,
                              child: child),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
