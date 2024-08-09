import 'package:collection/collection.dart';

extension ListExtension<T> on List<T> {
  // ignore: strict_raw_type
  List<T> customOrderBy(Comparable Function(T) criteria) {
    return sortedByCompare(
      (type) => criteria(type),
      (a, b) => b.compareTo(a),
    );
  }
}
