import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/ui_model/export_ui_model.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/core/extension/list_extension.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/data/export_data.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/domain/model/caught_pokemon_model.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/export_order_by.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/ui/routes/extra/order_extra.dart';

class _Constants {
  static const Duration timerInMilliseconds = Duration(milliseconds: 1500);
}

class CaughtPokemonBloc extends ChangeNotifier {
  CaughtPokemonBloc(this._caughtPokemonDatasource);

  final ValueNotifier<ScreenState> _screenState =
      ValueNotifier(ScreenState.idle);
  final CaughtPokemonDatasource _caughtPokemonDatasource;
  List<PokemonUIModel> _caughtPokemons = [];
  List<PokemonUIModel> _filteredCaughtPokemons = [];
  final TextEditingController _searchTEC = TextEditingController();
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  SelectedOrderModel _orderBy = SelectedOrderModel(type: OrderByType.id);

  ValueNotifier<ScreenState> get screenState => _screenState;
  List<PokemonUIModel> get filteredCaughtPokemons => _filteredCaughtPokemons;
  TextEditingController get searchTEC => _searchTEC;
  ScrollController get scrollController => _scrollController;
  SelectedOrderModel get orderBy => _orderBy;

  void clearSearchTEC() => _searchTEC.clear();

  Future<void> getCaughtPokemons() async {
    _screenState.value = ScreenState.loading;
    final result = await _caughtPokemonDatasource.getCaughtPokemons();

    result.whenWithResult(
      (success) {
        log('success getCaughtPokemons ${success.value.length}');
        _caughtPokemons =
            success.value.map((pokemon) => pokemon.toUiModel).toList();
        _generateColorByCaughtAndSave();
        _filteredCaughtPokemons = [..._caughtPokemons];
        _sortBy();
        _screenState.value =
            _caughtPokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
      },
      (error) {
        log('error getCaughtPokemons $error');
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
        _caughtPokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
  }

  void _filterBy() {
    final filtered = _caughtPokemons.where((pokemon) {
      final searchText = _searchTEC.text.trim().toLowerCase();
      final name = pokemon.name.toLowerCase();
      final pokedexNum = pokemon.pokedexNum.pokedexNum;
      return name.contains(searchText) || pokedexNum.contains(searchText);
    }).toList();
    _filteredCaughtPokemons = filtered;
  }

  void _sortBy() => switch (_orderBy.type) {
        OrderByType.alphabetical =>
          _filteredCaughtPokemons.sortBy((pokemon) => pokemon.name),
        OrderByType.pokemonType =>
          _filteredCaughtPokemons = _filteredCaughtPokemons
              .customOrderBy((pokemon) => pokemon.pokedexNum ?? 0)
              .reversed
              .where((pokemon) => pokemon.types.contains(_orderBy.pokemonType))
              .toList(),
        OrderByType.shiny => _filteredCaughtPokemons = _filteredCaughtPokemons
            .customOrderBy((pokemon) => pokemon.pokedexNum ?? 0)
            .reversed
            .where((pokemon) => pokemon.isShiny)
            .toList(),
        OrderByType.id => _filteredCaughtPokemons = _filteredCaughtPokemons
            .customOrderBy((pokemon) => pokemon.pokedexNum ?? 0)
            .reversed
            .toList(),
      };

  Future<void> navigateToOrderBy(BuildContext ctx) async {
    final result = await ctx.push(
      OrderByRoutes.orderBy,
      extra: OrderExtra(
        orderBy: _orderBy,
        enableByAlphabetical: true,
        enableByPokemonType: true,
        enableByShiny: true,
      ),
    );
    if (result != null && result is SelectedOrderModel) {
      _screenState.value = ScreenState.loading;
      _orderBy = result;
      _filteredCaughtPokemons = [..._caughtPokemons];
      _filterBy();
      _sortBy();
      _screenState.value =
          _caughtPokemons.isEmpty ? ScreenState.empty : ScreenState.idle;
    }
  }

  Future<void> caughtPokemon({
    required CaughtPokemonModel pokemon,
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    final result = await _caughtPokemonDatasource.addCaughtPokemon(pokemon);
    result.whenWithResult(
      (success) => onSuccess(),
      (error) => onError(),
    );
    await getCaughtPokemons();
  }

  Future<void> freePokemon({
    required String name,
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    final result = await _caughtPokemonDatasource.deleteCaughtPokemon(name);
    result.whenWithResult(
      (success) => onSuccess(),
      (error) => onError(),
    );
    await getCaughtPokemons();
  }

  Future<bool?> isCaught(String name) async {
    final result = await _caughtPokemonDatasource.isCaught(name);
    return result.whenWithResult(
      (success) => success.value,
      (error) => null,
    );
  }

  void _generateColorByCaughtAndSave() {
    final Map<PokemonType, int> pokeTypeCount =
        _caughtPokemons.fold({}, (previousValue, pokemon) {
      for (final type in pokemon.types) {
        previousValue[type] = (previousValue[type] ?? 0) + 1;
      }
      return previousValue;
    });

    log('pokeTypeCount: $pokeTypeCount');

    Color color = CustomColors.red;
    if (pokeTypeCount.isNotEmpty) {
      final int maxCount = pokeTypeCount.values
          .reduce((type1, type2) => type1 > type2 ? type1 : type2);

      final List<PokemonType> pokeTypesWithMaxCount = pokeTypeCount.keys
          .where((key) => pokeTypeCount[key] == maxCount)
          .toList();

      color =
          (pokeTypesWithMaxCount.isEmpty || pokeTypesWithMaxCount.length > 1)
              ? CustomColors.red
              : pokeTypesWithMaxCount.first.color;

      log('generated Color: $color');
    }

    locator<AppBloc>().updatePrimaryColor(color);
  }
}
