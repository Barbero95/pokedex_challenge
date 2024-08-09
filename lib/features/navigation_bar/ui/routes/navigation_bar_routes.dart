import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/features/navigation_bar/ui/export_ui.dart';

class NavigationBarRoutes {
  NavigationBarRoutes._();

  static const navigationBar = '/';

  static List<GoRoute> routes = [
    GoRoute(
      path: navigationBar,
      builder: _navigationBarRouteBuilder,
    ),
  ];

  static Widget _navigationBarRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const NavigationBarPage();
  }
}
