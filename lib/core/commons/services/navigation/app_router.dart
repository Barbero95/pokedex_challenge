import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/features/navigation_bar/export_navigation_bar.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/export_order_by.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';

class AppRouter {
  static GoRouter get router => _router;

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Center(child: Text('Error page')));

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      ...NavigationBarRoutes.routes,
      ...PokemonDetailRoutes.routes,
      ...OrderByRoutes.routes,
    ],
    errorBuilder: errorWidget,
  );
}
