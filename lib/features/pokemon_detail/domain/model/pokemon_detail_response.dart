import 'dart:convert';

import 'package:pokedex_code_challenge_21a/core/commons/domain/enums/export_enums.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/pokemon_type/export_pokemon_type.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/ui_model/export_ui_model.dart';

class PokemonDetailResponse {
  final double height;
  final double weight;
  final List<PokemonTypeModel> types;
  final List<PokemonStatModel> stats;
  final String name;
  final int id;

  PokemonDetailResponse({
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    required this.name,
    required this.id,
  });

  PokemonDetailResponse copyWith({
    double? height,
    double? weight,
    List<PokemonTypeModel>? types,
    List<PokemonStatModel>? stats,
    String? name,
    int? id,
  }) {
    return PokemonDetailResponse(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
      stats: stats ?? this.stats,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'weight': weight,
      'types': types.map((x) => x.toMap()).toList(),
      'stats': stats.map((x) => x.toMap()).toList(),
      'name': name,
      'id': id,
    };
  }

  factory PokemonDetailResponse.fromMap(Map<String, dynamic> map) {
    return PokemonDetailResponse(
      height: double.tryParse(map['height'].toString()) ?? 0,
      weight: double.tryParse(map['weight'].toString()) ?? 0,
      types: (map['types'] as List)
          .map<PokemonTypeModel>(
            (type) => PokemonTypeModel.fromMap(type as Map<String, dynamic>),
          )
          .toList(),
      stats: (map['stats'] as List)
          .map<PokemonStatModel>(
            (stat) => PokemonStatModel.fromMap(stat as Map<String, dynamic>),
          )
          .toList(),
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonDetailResponse.fromJson(String source) =>
      PokemonDetailResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'PokemonDetailResponse(height: $height, weight: $weight, types: $types, stats: $stats, name: $name, id: $id)';
  }

  PokemonDetailUIModel toUIModel(
    bool isShiny,
  ) =>
      PokemonDetailUIModel(
        height: height,
        weight: weight,
        types: types
            .map((type) => PokemonType.fromText(type.name))
            .where((type) => type != null)
            .toList()
            .cast<PokemonType>(),
        stats: stats
            .map(
              (stat) {
                final statType = PokemonStatType.fromText(stat.name);
                if (stat.baseStat == null || statType == null) return null;
                return PokemonStatUIModel(
                  type: statType,
                  value: stat.baseStat!,
                );
              },
            )
            .where((type) => type != null)
            .toList()
            .cast<PokemonStatUIModel>(),
        name: name,
        pokedexNum: id,
        isShiny: isShiny,
      );
}
