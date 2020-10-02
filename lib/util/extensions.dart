import 'package:collection/collection.dart';

extension StringExtentions on String {
  String orEmpty() {
    return this ?? "";
  }
}

extension ListExtentions on List {
  List orEmpty() {
    return this ?? List();
  }

  bool isEqual(List other) {
    if (other == null) return false;
    return ListEquality().equals(this, other);
  }

  int getHashCode() {
    int result = 0;
    forEach((element) {
      result ^= element.hashCode;
    });
    return result;
  }
}

extension IntExtentions on int {
  int orZero() {
    return this ?? 0;
  }
}

extension BooleanExtentions on bool {
  bool orFalse() {
    return this ?? false;
  }
}
