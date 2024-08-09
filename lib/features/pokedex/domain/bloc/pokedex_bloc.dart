import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/export_order_by.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/ui/routes/extra/order_extra.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/data/export_data.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/domain/export_domain.dart';

class _Constants {
  static const int limit = 151;
  static const int offset = 0;
  static const Duration timerInMilliseconds = Duration(milliseconds: 1500);
}

class PokedexBloc {
  PokedexBloc(this._pokedexDatasource);

  final ValueNotifier<ScreenState> _screenState =
      ValueNotifier(ScreenState.idle);
  final PokedexDatasource _pokedexDatasource;
  final PokedexRequest _pokedexRequest = PokedexRequest(
    limit: _Constants.limit,
    offset: _Constants.offset,
  );
  List<PokemonUIModel> _pokemons = [];
  List<PokemonUIModel> _filteredPokemons = [];
  final TextEditingController _searchTEC = TextEditingController();
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  SelectedOrderModel _orderBy = SelectedOrderModel(type: OrderByType.id);

  ValueNotifier<ScreenState> get screenState => _screenState;
  List<PokemonUIModel> get filteredPokemons => _filteredPokemons;
  TextEditingController get searchTEC => _searchTEC;
  ScrollController get scrollController => _scrollController;
  SelectedOrderModel get orderBy => _orderBy;

  void clearSearchTEC() => _searchTEC.clear();

  Future<void> getPokedex() async {
    _screenState.value = ScreenState.loading;
    final result = await _pokedexDatasource.getPokemons(_pokedexRequest);

    result.whenWithResult(
      (success) {
        log('success getPokedex ${success.value.results.length}');
        _pokemons =
            success.value.results.map((pokemon) => pokemon.toUiModel).toList();
        _filteredPokemons = [..._pokemons];
        _screenState.value =
            _pokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
      },
      (error) {
        log('error getPokedex $error');
        _screenState.value = ScreenState.error;
      },
    );
  }

  void onChangedSearch() {
    _timer?.cancel();
    _timer = Timer(_Constants.timerInMilliseconds, filterPokemons);
  }

  void filterPokemons() {
    _screenState.value = ScreenState.loading;
    _timer?.cancel();
    _filterBy();
    _sortBy();
    _screenState.value =
        _pokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
  }

  void _filterBy() {
    final filtered = _pokemons.where((pokemon) {
      final name = pokemon.name.toLowerCase();
      return name.contains(_searchTEC.text.trim().toLowerCase());
    }).toList();
    _filteredPokemons = filtered;
  }

  void _sortBy() {
    if (_orderBy.type == OrderByType.alphabetical) {
      _filteredPokemons.sortBy((pokemon) => pokemon.name);
    }
  }

  Future<void> navigateToOrderBy(BuildContext ctx) async {
    final result = await ctx.push(
      OrderByRoutes.orderBy,
      extra: OrderExtra(
        orderBy: _orderBy,
        enableByAlphabetical: true,
      ),
    );
    if (result != null && result is SelectedOrderModel) {
      _screenState.value = ScreenState.loading;
      _orderBy = result;
      _filteredPokemons = [..._pokemons];
      _filterBy();
      _sortBy();
      _screenState.value =
          _pokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
    }
  }
}
