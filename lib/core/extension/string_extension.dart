extension StringExtension on String {
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  int? get extractNumberFromPokeApiUrl {
    final RegExp regex = RegExp(r'\/(\d+)\/$');
    final match = regex.firstMatch(this);

    if (match != null && match.group(1) != null) {
      return int.tryParse(match.group(1)!);
    }

    return null;
  }
}
