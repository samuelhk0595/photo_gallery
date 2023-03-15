import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class PhotoGridTile extends StatelessWidget {
  const PhotoGridTile({
    super.key,
    required this.photo,
    required this.onTap,
    required this.isFavorite,
    required this.borderRadius,
  });

  final PhotoEntity photo;
  final void Function() onTap;
  final bool isFavorite;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          margin: const EdgeInsets.all(1),
          decoration: const BoxDecoration(color: Colors.white12),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.network(
                  photo.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildFadeWidget(),
              Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        photo.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ))),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  isFavorite
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: isFavorite ? Colors.red : Colors.white54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildFadeWidget() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
            0.6,
            0.8,
            0.98,
          ],
              colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.7),
          ])),
    );
  }
}
