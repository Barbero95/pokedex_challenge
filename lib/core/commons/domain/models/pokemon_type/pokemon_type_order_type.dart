import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

enum PokemonTypeOrdertype {
  alphabetical,
  color,
  lightness,
  vg,
  guide,
  alt,
  pokedex;

  String label(BuildContext ctx) => switch (this) {
        alphabetical => ctx.trl.pokemon_order_alphabetical_label,
        color => ctx.trl.pokemon_order_color_label,
        lightness => ctx.trl.pokemon_order_lightness_label,
        vg => ctx.trl.pokemon_order_vg_order_label,
        guide => ctx.trl.pokemon_order_guide_label,
        alt => ctx.trl.pokemon_order_alt_label,
        pokedex => ctx.trl.pokemon_order_pokedex_label,
      };

  String description(BuildContext ctx) => switch (this) {
        alphabetical => ctx.trl.pokemon_order_alphabetical_description,
        color => ctx.trl.pokemon_order_color_description,
        lightness => ctx.trl.pokemon_order_lightness_description,
        vg => ctx.trl.pokemon_order_vg_description,
        guide => ctx.trl.pokemon_order_guide_description,
        alt => ctx.trl.pokemon_order_alt_description,
        pokedex => ctx.trl.pokemon_order_pokedex_description,
      };
}
