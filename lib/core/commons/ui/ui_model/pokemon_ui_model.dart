import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';

class PokemonUIModel {
  final String name;
  final int? pokedexNum;
  final bool isShiny;
  final List<PokemonType> types;
  final bool isFromPokedex;

  PokemonUIModel({
    required this.name,
    required this.pokedexNum,
    required this.isShiny,
    this.types = const [],
    required this.isFromPokedex,
  });
}
