import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/extension/translation_extension.dart';

enum PokemonStatType {
  hp('hp'),
  attack('attack'),
  defense('defense'),
  specialAttack('special-attack'),
  specialDefense('special-defense'),
  speed('speed'),
  accuracy('accuracy'),
  evasion('evasion');

  final String name;

  const PokemonStatType(this.name);

  static PokemonStatType? fromText(String? text) {
    if (text == null || text.isEmpty) return null;
    return values.firstWhereOrNull(
      (type) => type.name.toLowerCase() == text.toLowerCase(),
    );
  }

  String label(BuildContext ctx) => switch (this) {
        hp => ctx.trl.hp_label,
        attack => ctx.trl.attack_label,
        defense => ctx.trl.defense_label,
        specialAttack => ctx.trl.special_attack_label,
        specialDefense => ctx.trl.special_defense_label,
        speed => ctx.trl.speed_label,
        accuracy => ctx.trl.accuracy_label,
        evasion => ctx.trl.evasion_label,
      };
}
