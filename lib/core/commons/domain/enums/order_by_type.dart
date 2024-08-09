import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

enum OrderByType {
  id,
  alphabetical,
  pokemonType,
  shiny;


  bool get isById => this == id;
  bool get isByAlphabetical => this == alphabetical;
  bool get isByPokemonType => this == pokemonType;
  bool get isByShiny => this == shiny;


  static List<OrderByType> getValues({
    bool enableByAlphabetical = false,
    bool enableByPokemonType = false,
    bool enableByShiny = false,

  }) =>
      [
        id,
        if (enableByAlphabetical) alphabetical,
        if (enableByPokemonType) pokemonType,
        if (enableByShiny) shiny,

      ];
  String label(BuildContext ctx) => switch (this) {
        id => ctx.trl.type_label,
        alphabetical => ctx.trl.pokemon_order_alphabetical_label,
        pokemonType => ctx.trl.pokemon_order_pokedex_label,
        shiny => ctx.trl.shiny_label,
      };
}
