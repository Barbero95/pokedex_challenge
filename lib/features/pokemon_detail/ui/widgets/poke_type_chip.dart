import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

class PokeTypeChip extends StatelessWidget {
  final PokemonType type;
  const PokeTypeChip({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        type.label(context).capitalize,
        style: const TextStyle(
          color: CustomColors.white,
          fontWeight: CustomFontWeight.semibold,
        ),
      ),
      backgroundColor: type.color,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Spaces.spaceXXXL,
        ),
      ),
    );
  }
}
