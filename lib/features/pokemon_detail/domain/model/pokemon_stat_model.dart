class PokemonStatModel {
  final String name;
  final int effort;
  final double? baseStat;

  PokemonStatModel({
    required this.name,
    required this.effort,
    required this.baseStat,
  });

  PokemonStatModel copyWith({
    String? name,
    int? effort,
    double? baseStat,
  }) {
    return PokemonStatModel(
      name: name ?? this.name,
      effort: effort ?? this.effort,
      baseStat: baseStat ?? this.baseStat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'effort': effort,
      'baseStat': baseStat,
    };
  }

  factory PokemonStatModel.fromMap(Map<String, dynamic> map) {
    final stat = map['stat'] as Map<String, dynamic>;

    return PokemonStatModel(
      name: stat['name'] as String,
      effort: map['effort'] as int? ?? 0,
      baseStat: double.tryParse(map['base_stat'].toString()) ?? 0,
    );
  }

  @override
  String toString() =>
      'PokemonStatModel(name: $name, effort: $effort, baseStat: $baseStat)';
}
