import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/widgets/export_widgets.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/export_caught_pokemon.dart';

class _Constants {
  static const double searchBarElevation = 1;
  static const double filterIconSize = 20;
}

class CaughtPokemonPage extends StatefulWidget {
  final void Function() goToPokedex;
  const CaughtPokemonPage({
    super.key,
    required this.goToPokedex,
  });

  @override
  State<CaughtPokemonPage> createState() => _CaughtPokemonPageState();
}

class _CaughtPokemonPageState extends State<CaughtPokemonPage> {
  late CaughtPokemonBloc _caughtPokemonBloc;

  @override
  void initState() {
    super.initState();
    _caughtPokemonBloc = locator<CaughtPokemonBloc>()..getCaughtPokemons();
  }

  Widget get _empty => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.trl.zero_caught_pokemons_title),
            Spaces.verticalXS,
            FilledButton(
              onPressed: widget.goToPokedex,
              style: CustomButtonStyles.filledButton,
              child: Text(context.trl.go_to_pokedex_title),
            ),
          ],
        ),
      );

  Widget get _zeroResults => Expanded(
        child: Center(
          child: Text(context.trl.zero_results_title),
        ),
      );

  Widget get _error => Center(
        child: Text(context.trl.generic_error_title),
      );

  Widget get _loading => const Center(
        child: CircularProgressIndicator(),
      );

  Widget get _searchBar => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spaces.spaceXS,
          vertical: Spaces.spaceXS,
        ),
        child: SearchBar(
          controller: _caughtPokemonBloc.searchTEC,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: Spaces.spaceXS,
            ),
          ),
          onChanged: (_) => _caughtPokemonBloc.onChangedSearch(),
          onSubmitted: (_) => _caughtPokemonBloc.filterPokemons(),
          hintText: context.trl.search_bar_label,
          leading: const Icon(Icons.search),
          trailing: [
            if (_caughtPokemonBloc.searchTEC.text.trim().isNotEmpty)
              IconButton(
                onPressed: () => _caughtPokemonBloc
                  ..clearSearchTEC()
                  ..filterPokemons(),
                icon: const Icon(
                  Icons.close,
                ),
              ),
            IconButton(
              onPressed: () => _caughtPokemonBloc.navigateToOrderBy(context),
              icon: Icon(
                _caughtPokemonBloc.orderBy.type.isById
                    ? FontAwesomeIcons.filter
                    : FontAwesomeIcons.filterCircleXmark,
                size: _Constants.filterIconSize,
              ),
            ),
          ],
          elevation: const WidgetStatePropertyAll(
            _Constants.searchBarElevation,
          ),
        ),
      );

  Widget get _content {
    final filteredPokemons = _caughtPokemonBloc.filteredCaughtPokemons;
    return Column(
      children: [
        _searchBar,
        if (filteredPokemons.isEmpty)
          _zeroResults
        else
          PokemonGrid(
            pokemons: filteredPokemons,
            scrollController: _caughtPokemonBloc.scrollController,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _caughtPokemonBloc.screenState,
      builder: (_, screenState, __) => switch (screenState) {
        ScreenState.empty => _empty,
        ScreenState.error => _error,
        ScreenState.loading => _loading,
        ScreenState.idle => _content,
      },
    );
  }
}
