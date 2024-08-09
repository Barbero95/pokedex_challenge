import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

class PokemonTypeModel {
  final String name;
  final int? id;

  PokemonTypeModel({
    required this.name,
    required this.id,
  });

  PokemonTypeModel copyWith({
    String? name,
    int? id,
  }) {
    return PokemonTypeModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory PokemonTypeModel.fromMap(Map<String, dynamic> map) {
    final type = map['type'] as Map<String, dynamic>;
    return PokemonTypeModel(
      name: type['name'] as String,
      id: (type['url'] as String).extractNumberFromPokeApiUrl,
    );
  }

  @override
  String toString() => 'PokemonTypeModel(name: $name, id: $id)';
}
