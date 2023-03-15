import 'package:photo_gallery/app/core/failure.dart';

class CantGetPhotosFailure extends Failure{
  @override
  String get message => 'Something went wrong, we can\'t load the photos right now.';

}