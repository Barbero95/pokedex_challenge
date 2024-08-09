// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pokedex_code_challenge_21a/core/commons/domain/enums/export_enums.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';

class SelectedOrderModel {
  OrderByType type;
  PokemonType? pokemonType;

  SelectedOrderModel({
    required this.type,
    this.pokemonType,
  });
}
