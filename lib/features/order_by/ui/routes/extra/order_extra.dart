import 'package:pokedex_code_challenge_21a/features/order_by/export_order_by.dart';

class OrderExtra {
  SelectedOrderModel orderBy;
  bool enableByAlphabetical;
  bool enableByPokemonType;
  bool enableByShiny;

  OrderExtra({
    required this.orderBy,
    this.enableByAlphabetical = false,
    this.enableByPokemonType = false,
    this.enableByShiny = false,
  });
}
