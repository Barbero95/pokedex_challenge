import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/widgets/export_widgets.dart';

class _Constants {
  static const double maxWidth = 600;
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: CustomFontSize.s24,
    fontWeight: CustomFontWeight.semibold,
  );
  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: CustomFontSize.s20,
    fontWeight: CustomFontWeight.semibold,
  );
}

class PokeAboutWidget extends StatelessWidget {
  final PokemonDetailUIModel? pokemonDetailUIModel;
  const PokeAboutWidget({
    super.key,
    required this.pokemonDetailUIModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: _Constants.maxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.trl.data_title,
            style: _Constants.titleTextStyle,
          ),
          Spaces.verticalXS,
          PokeAboutItemWidget(
            title: context.trl.pokemon_detail_height_label,
            value: pokemonDetailUIModel?.height,
            icon: FontAwesomeIcons.upDown,
          ),
          Spaces.verticalXXS,
          PokeAboutItemWidget(
            title: context.trl.pokemon_detail_weight_label,
            value: pokemonDetailUIModel?.weight,
            icon: FontAwesomeIcons.weightHanging,
          ),
          Spaces.verticalXS,
          Text(
            context.trl.pokemon_detail_stats_subtitle,
            style: _Constants.subtitleTextStyle,
          ),
          Spaces.verticalXXS,
          if (pokemonDetailUIModel?.stats != null)
            PokeStatsTableWidget(stats: pokemonDetailUIModel!.stats),
          Spaces.verticalXXXL,
        ],
      ),
    );
  }
}
