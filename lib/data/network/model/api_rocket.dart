import 'package:rocket_launcher/util/extensions.dart';

class ApiRocket {
  ApiRocket._(this.id, this.name, this.country, this.description, this.images,
      this.enginesCount, this.isActive);

  final String id;
  final String name;
  final String country;
  final String description;
  final List<String> images;
  final int enginesCount;
  final bool isActive;

  factory ApiRocket.makeRocket(
      {String id = "",
      String name = "",
      String country = "",
      String description = "",
      List<String> images = const [],
      int enginesCount = 0,
      bool isActive = false}) {
    return ApiRocket._(
        id.orEmpty(),
        name.orEmpty(),
        country.orEmpty(),
        description.orEmpty(),
        images.orEmpty(),
        enginesCount.orZero(),
        isActive.orFalse());
  }
}
