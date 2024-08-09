import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/enums/export_enums.dart';

class PokemonStatUIModel {
  final PokemonStatType type;
  final double value;

  PokemonStatUIModel({
    required this.type,
    required this.value,
  });

  String label(BuildContext ctx) => type.label(ctx);
}
