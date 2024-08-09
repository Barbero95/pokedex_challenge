import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/BLoC/export_bloc.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/widgets/export_widgets.dart';

class PokemonGrid extends StatelessWidget {
  final ScrollController scrollController;
  final List<PokemonUIModel> pokemons;

  const PokemonGrid({
    super.key,
    required this.scrollController,
    required this.pokemons,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = AppBloc.isMobile(constraints);
          int crossAxisCount = (constraints.maxWidth / 200).floor();
          if (crossAxisCount < 2) crossAxisCount = 2;
          return Scrollbar(
            trackVisibility: !isMobile,
            thumbVisibility: !isMobile,
            controller: scrollController,
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: Spaces.spaceXS),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              ),
              itemCount: pokemons.length,
              itemBuilder: (context, index) => PokemonCard(
                pokemon: pokemons[index],
                horizontal: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
