class _Constants {
  static const undefinedPokedexNum = '#???';
}

extension IntExtension on int? {
  String get pokedexNum {
    if (this == null) return _Constants.undefinedPokedexNum;
    return '#${toString().padLeft(3, '0')}';
  }
}
