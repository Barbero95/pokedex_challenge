import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/pokemon_type/pokemon_type_order.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/extension/list_extension.dart';
import 'package:pokedex_code_challenge_21a/core/extension/translation_extension.dart';

part 'pokemon_type.g.dart';

@HiveType(typeId: 2)
enum PokemonType {
  @HiveField(0)
  normal(
    color: CustomColors.normalPT,
    order: PokemonTypeOrder(
      color: 15,
      lightness: 14,
      vg: 0,
      guide: 0,
      alt: 0,
    ),
  ),
  @HiveField(1)
  fire(
    color: CustomColors.firePT,
    order: PokemonTypeOrder(
      color: 1,
      lightness: 6,
      vg: 9,
      guide: 11,
      alt: 1,
    ),
  ),
  @HiveField(2)
  water(
    color: CustomColors.waterPT,
    order: PokemonTypeOrder(
      color: 8,
      lightness: 5,
      vg: 10,
      guide: 12,
      alt: 2,
    ),
  ),
  @HiveField(3)
  electric(
    color: CustomColors.electricPT,
    order: PokemonTypeOrder(
      color: 4,
      lightness: 17,
      vg: 12,
      guide: 13,
      alt: 4,
    ),
  ),
  @HiveField(4)
  grass(
    color: CustomColors.grassPT,
    order: PokemonTypeOrder(
      color: 6,
      lightness: 10,
      vg: 11,
      guide: 14,
      alt: 3,
    ),
  ),
  @HiveField(5)
  psychic(
    color: CustomColors.psychicPT,
    order: PokemonTypeOrder(
      color: 14,
      lightness: 7,
      vg: 13,
      guide: 16,
      alt: 10,
    ),
  ),
  @HiveField(6)
  fighting(
    color: CustomColors.fightingPT,
    order: PokemonTypeOrder(
      color: 0,
      lightness: 3,
      vg: 1,
      guide: 1,
      alt: 6,
    ),
  ),
  @HiveField(7)
  poison(
    color: CustomColors.poisonPT,
    order: PokemonTypeOrder(
      color: 12,
      lightness: 4,
      vg: 3,
      guide: 2,
      alt: 7,
    ),
  ),
  @HiveField(8)
  ground(
    color: CustomColors.groundPT,
    order: PokemonTypeOrder(
      color: 2,
      lightness: 13,
      vg: 4,
      guide: 3,
      alt: 8,
    ),
  ),
  @HiveField(9)
  flying(
    color: CustomColors.flyingPT,
    order: PokemonTypeOrder(
      color: 9,
      lightness: 11,
      vg: 2,
      guide: 4,
      alt: 9,
    ),
  ),
  @HiveField(10)
  dragon(
    color: CustomColors.dragonPT,
    order: PokemonTypeOrder(
      color: 10,
      lightness: 2,
      vg: 15,
      guide: 9,
      alt: 14,
    ),
  ),
  @HiveField(11)
  bug(
    color: CustomColors.bugPT,
    order: PokemonTypeOrder(
      color: 5,
      lightness: 12,
      vg: 6,
      guide: 5,
      alt: 11,
    ),
  ),
  @HiveField(12)
  rock(
    color: CustomColors.rockPT,
    order: PokemonTypeOrder(
      color: 3,
      lightness: 9,
      vg: 5,
      guide: 6,
      alt: 12,
    ),
  ),
  @HiveField(13)
  ghost(
    color: CustomColors.ghostPT,
    order: PokemonTypeOrder(
      color: 11,
      lightness: 1,
      vg: 7,
      guide: 7,
      alt: 13,
    ),
  ),
  @HiveField(14)
  ice(
    color: CustomColors.icePT,
    order: PokemonTypeOrder(
      color: 7,
      lightness: 15,
      vg: 14,
      guide: 15,
      alt: 5,
    ),
  ),
  @HiveField(15)
  steel(
    color: CustomColors.steelPT,
    order: PokemonTypeOrder(
      color: 16,
      lightness: 8,
      vg: 8,
      guide: 8,
      alt: 16,
    ),
  ),
  @HiveField(16)
  dark(
    color: CustomColors.darkPT,
    order: PokemonTypeOrder(
      color: 17,
      lightness: 0,
      vg: 16,
      guide: 10,
      alt: 15,
    ),
  ),
  @HiveField(17)
  fairy(
    color: CustomColors.fairyPT,
    order: PokemonTypeOrder(
      color: 13,
      lightness: 16,
      vg: 17,
      guide: 17,
      alt: 17,
    ),
  );

  final Color color;
  final PokemonTypeOrder order;

  const PokemonType({
    required this.color,
    required this.order,
  });

  List<PokemonType> orderAlphabetical(BuildContext ctx) =>
      values..sortedBy((type) => type.label(ctx));
  List<PokemonType> get orderColor => values.customOrderBy(
        (type) => type.order.color,
      );
  List<PokemonType> get orderLightness => values.customOrderBy(
        (type) => type.order.lightness,
      );
  List<PokemonType> get orderVG => values.customOrderBy(
        (type) => type.order.vg,
      );
  List<PokemonType> get orderGuide => values.customOrderBy(
        (type) => type.order.guide,
      );
  List<PokemonType> get orderAlt => values.customOrderBy(
        (type) => type.order.alt,
      );
  List<PokemonType> get orderPokedex => values;

  static PokemonType? fromText(String? text) {
    if (text == null || text.isEmpty) return null;
    return values.firstWhereOrNull(
      (type) => type.name.toLowerCase() == text.toLowerCase(),
    );
  }

  String label(BuildContext ctx) => switch (this) {
        normal => ctx.trl.normal_label,
        fire => ctx.trl.fire_label,
        water => ctx.trl.water_label,
        electric => ctx.trl.electric_label,
        grass => ctx.trl.grass_label,
        psychic => ctx.trl.psychic_label,
        fighting => ctx.trl.fighting_label,
        poison => ctx.trl.poison_label,
        ground => ctx.trl.ground_label,
        flying => ctx.trl.flying_label,
        dragon => ctx.trl.dragon_label,
        bug => ctx.trl.bug_label,
        rock => ctx.trl.rock_label,
        ghost => ctx.trl.ghost_label,
        ice => ctx.trl.ice_label,
        steel => ctx.trl.steel_label,
        dark => ctx.trl.dark_label,
        fairy => ctx.trl.fairy_label,
      };
}
