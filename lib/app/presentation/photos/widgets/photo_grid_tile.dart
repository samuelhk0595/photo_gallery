import 'package:flutter/material.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class PhotoGridTile extends StatelessWidget {
  const PhotoGridTile({
    super.key,
    required this.photo,
    required this.onTap,
    required this.onLongPress,
    required this.isSelected,
  });

  final PhotoEntity photo;
  final void Function() onLongPress;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,

        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.blue,
          border:isSelected ? Border.all(color: Colors.amberAccent,
          width: 3,
          ) : null,
        ),
        child: Image.network(
          photo.thumbnailUrl,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return Stack(
              children: [
                Positioned(top: 0, left: 0, right: 0, bottom: 0, child: child),
                Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          photo.title,
                          textAlign: TextAlign.center,
                        )))
              ],
            );
          },
        ),
      ),
    );
  }
}
