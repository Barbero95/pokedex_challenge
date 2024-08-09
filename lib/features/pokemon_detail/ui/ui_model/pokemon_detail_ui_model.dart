import 'dart:ui';

import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/domain/model/export_model.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/ui_model/export_ui_model.dart';

class PokemonDetailUIModel {
  final double height;
  final double weight;
  final List<PokemonType> types;
  final List<PokemonStatUIModel> stats;
  final String name;
  final int pokedexNum;
  final bool isShiny;

  PokemonDetailUIModel({
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    required this.name,
    required this.pokedexNum,
    required this.isShiny,
  });

  Color? get backgroundColor => types.isNotEmpty ? types.first.color : null;

  @override
  String toString() {
    return 'PokemonDetailUIModel(height: $height, weight: $weight, types: $types, stats: $stats, name: $name, pokedexNum: $pokedexNum, isShiny: $isShiny)';
  }

  CaughtPokemonModel get toCaughtPokeUIModel => CaughtPokemonModel(
        name: name,
        pokedexNum: pokedexNum,
        types: types,
        isShiny: isShiny,
      );
}
