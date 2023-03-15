import 'package:photo_gallery/app/domain/photo/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  PhotoModel(
      {required super.albumId,
      required super.id,
      required super.title,
      required super.url,
      required super.thumbnailUrl});

  factory PhotoModel.fromJsonPlaceHolder(Map<String, dynamic> json) {
    return PhotoModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  factory PhotoModel.fromPexels(Map<String, dynamic> json) {
    return PhotoModel(
      albumId: json['photographer_id'],
      id: json['id'],
      title: json['photographer'],
      url: json['src']['large2x'],
      thumbnailUrl: json['src']['portrait'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
