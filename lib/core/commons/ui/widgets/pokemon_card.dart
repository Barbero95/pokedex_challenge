import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';

class _Constants {
  static const double opacity = .6;
}

class PokemonCard extends StatelessWidget {
  final PokemonUIModel pokemon;
  final bool horizontal;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.horizontal,
  });

  Widget get _image => Hero(
        tag: '${pokemon.name}_${pokemon.isFromPokedex}',
        child: PokemonImageWidget(
          pokemon: pokemon.pokedexNum,
          isShiny: pokemon.isShiny && !pokemon.isFromPokedex,
        ),
      );

  Widget get _name => Text(
        pokemon.name.capitalize,
        style: const TextStyle(
          fontSize: CustomFontSize.s16,
          color: CustomColors.neutralBlack,
          fontWeight: CustomFontWeight.semibold,
        ),
      );

  Widget get _pokedexNum => Text(
        pokemon.pokedexNum.pokedexNum,
        style: const TextStyle(
          fontSize: CustomFontSize.s14,
          color: CustomColors.neutralBlack,
          fontWeight: CustomFontWeight.regular,
        ),
      );

  BoxDecoration get _boxDecoration {
    final defaultBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(
        Spaces.spaceXXS,
      ),
    );
    if (pokemon.types.isEmpty) return defaultBoxDecoration;
    if (pokemon.types.length == 1) {
      return defaultBoxDecoration.copyWith(
        color: pokemon.types.first.color.withOpacity(
          _Constants.opacity,
        ),
      );
    }
    return defaultBoxDecoration.copyWith(
      gradient: LinearGradient(
        colors: pokemon.types
            .map(
              (type) => type.color.withOpacity(
                _Constants.opacity,
              ),
            )
            .toList(),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  Widget get _contentCard => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Spaces.spaceXXS,
          ),
        ),
        child: DecoratedBox(
          decoration: _boxDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image,
              _name,
              Spaces.verticalXXS,
              _pokedexNum,
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        PokemonDetailRoutes.pokemonDetail,
        extra: pokemon,
      ),
      child: _contentCard,
    );
  }
}
