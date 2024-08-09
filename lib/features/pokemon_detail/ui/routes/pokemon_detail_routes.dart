import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/export_ui.dart';

class PokemonDetailRoutes {
  PokemonDetailRoutes._();

  static const pokemonDetail = '/pokemon-detail';

  static List<GoRoute> routes = [
    GoRoute(
      path: pokemonDetail,
      builder: _pokemonDetailRouteBuilder,
    ),
  ];

  static Widget _pokemonDetailRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return PokemonDetailPage(
      pokemon: state.extra! as PokemonUIModel,
    );
  }
}
