import 'package:rocket_launcher/util/extensions.dart';

class Rocket {
  Rocket._(this.id, this.name, this.country, this.description, this.images, this.enginesCount,
      this.isActive);

  final String id;
  final String name;
  final String country;
  final String description;
  final List<String> images;
  final int enginesCount;
  final bool isActive;

  factory Rocket.makeRocket({
    String id = "",
      String name = "",
      String country = "",
      String description = "",
      List<String> images = const [],
      int enginesCount = 0,
      bool isActive = false}) {
    return Rocket._(id.orEmpty(), name.orEmpty(), country.orEmpty(), description.orEmpty(),
        images.orEmpty(), enginesCount.orZero(), isActive.orFalse());
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is Rocket &&
            id == other.id &&
            name == other.name &&
            country == other.country &&
            description == other.description &&
            images.isEqual(other.images) &&
            enginesCount == other.enginesCount &&
            isActive == other.isActive;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      country.hashCode ^
      description.hashCode ^
      images.getHashCode() ^
      enginesCount.hashCode ^
      isActive.hashCode;

  @override
  String toString() {
    String imagesString = "";
    images.forEach((element) {
      imagesString+="image = ${element.toString()}\n";
    });
    return "Rocket:\n"
        "id = ${id.toString()}\n"
        "name = ${name.toString()}\n"
        "country = ${country.toString()}\n"
        "description = ${description.toString()}\n"
        "$imagesString"
        "enginesCount = ${enginesCount.toString()}\n"
        "isActive = ${isActive.toString()}\n";
  }
}
