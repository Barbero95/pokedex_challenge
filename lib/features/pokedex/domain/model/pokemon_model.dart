import 'package:pokedex_code_challenge_21a/core/commons/services/shiny_random.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

class PokemonModel {
  final String name;
  final String url;

  PokemonModel({
    required this.name,
    required this.url,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  @override
  String toString() {
    return 'PokemonModel(name: $name, url: $url)';
  }

  PokemonUIModel get toUiModel => PokemonUIModel(
        name: name,
        pokedexNum: url.extractNumberFromPokeApiUrl,
        isShiny: ShinyRandom.isShiny,
        isFromPokedex: true,
      );
}
