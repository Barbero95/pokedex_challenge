import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/widgets/export_widgets.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/export_pokedex.dart';

class _Constants {
  static const double searchBarElevation = 1;
  static const double filterIconSize = 20;
}

class PokedexPage extends StatefulWidget {
  const PokedexPage({
    super.key,
  });

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late PokedexBloc _pokedexBloc;

  @override
  void initState() {
    super.initState();
    _pokedexBloc = locator<PokedexBloc>()..getPokedex();
  }

  Widget get _empty => Center(
        child: Text(context.trl.zero_pokemons_in_pokedex_title),
      );

  Widget get _error => Center(
        child: Text(context.trl.generic_error_title),
      );

  Widget get _loading => const Center(
        child: CircularProgressIndicator(),
      );

  Widget get _zeroResults => Expanded(
        child: Center(
          child: Text(context.trl.zero_results_title),
        ),
      );

  Widget get _searchBar => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spaces.spaceXS,
          vertical: Spaces.spaceXS,
        ),
        child: SearchBar(
          controller: _pokedexBloc.searchTEC,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: Spaces.spaceXS,
            ),
          ),
          onChanged: (_) => _pokedexBloc.onChangedSearch(),
          onSubmitted: (_) => _pokedexBloc.filterPokemons(),
          hintText: context.trl.search_bar_label,
          leading: const Icon(Icons.search),
          trailing: [
            if (_pokedexBloc.searchTEC.text.trim().isNotEmpty)
              IconButton(
                onPressed: () => _pokedexBloc
                  ..clearSearchTEC()
                  ..filterPokemons(),
                icon: const Icon(
                  Icons.close,
                ),
              ),
            IconButton(
              onPressed: () => _pokedexBloc.navigateToOrderBy(context),
              icon: Icon(
                _pokedexBloc.orderBy.type.isById
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
    return Column(
      children: [
        _searchBar,
        if (_pokedexBloc.filteredPokemons.isEmpty)
          _zeroResults
        else
          PokemonGrid(
            pokemons: _pokedexBloc.filteredPokemons,
            scrollController: _pokedexBloc.scrollController,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _pokedexBloc.screenState,
      builder: (_, screenState, __) => switch (screenState) {
        ScreenState.empty => _empty,
        ScreenState.error => _error,
        ScreenState.loading => _loading,
        ScreenState.idle => _content,
      },
    );
  }
}
