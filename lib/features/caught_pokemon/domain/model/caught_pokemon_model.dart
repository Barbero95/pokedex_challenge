import 'package:hive/hive.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';

part 'caught_pokemon_model.g.dart';

@HiveType(typeId: 0)
class CaughtPokemonModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int? pokedexNum;
  @HiveField(2)
  final List<PokemonType> types;
  @HiveField(3)
  final bool isShiny;

  CaughtPokemonModel({
    required this.name,
    required this.pokedexNum,
    required this.types,
    required this.isShiny,
  });

  PokemonUIModel get toUiModel => PokemonUIModel(
        name: name,
        pokedexNum: pokedexNum,
        types: types,
        isShiny: isShiny,
        isFromPokedex: false,
      );
}
