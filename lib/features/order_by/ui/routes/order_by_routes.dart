import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/domain/model/selected_order_model.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/ui/routes/extra/order_extra.dart';

class OrderByRoutes {
  OrderByRoutes._();

  static const orderBy = '/order-by';

  static List<GoRoute> routes = [
    GoRoute(
      path: orderBy,
      builder: _orderByRouteBuilder,
    ),
  ];

  static Widget _orderByRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    final orderExtra = state.extra as OrderExtra?;
    return OrderByPage(
      orderBy: orderExtra?.orderBy ??
          SelectedOrderModel(
            type: OrderByType.id,
          ),
      enableByAlphabetical: orderExtra?.enableByAlphabetical ?? false,
      enableByPokemonType: orderExtra?.enableByPokemonType ?? false,
      enableByShiny: orderExtra?.enableByShiny ?? false,
    );
  }
}
