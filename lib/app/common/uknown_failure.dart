import 'package:photo_gallery/app/core/failure.dart';

class UnknownFailure extends Failure{
  @override
  String get message => 'An unknown error has ocurred. Please try again.';

}