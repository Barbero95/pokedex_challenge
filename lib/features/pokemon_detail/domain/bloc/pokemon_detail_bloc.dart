import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/core/extension/translation_extension.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/export_caught_pokemon.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';

class PokemonDetailBloc extends ChangeNotifier {
  PokemonDetailBloc(
    this._pokemonDetailDatasource,
  );

  final ValueNotifier<ScreenState> _screenState =
      ValueNotifier(ScreenState.idle);
  final PokemonDetailDatasource _pokemonDetailDatasource;
  PokemonDetailUIModel? _pokemonDetailUIModel;
  final ValueNotifier<(ScreenState, bool?)> _isCaught =
      ValueNotifier((ScreenState.idle, null));
  bool _showBack = false;

  ValueNotifier<ScreenState> get screenState => _screenState;
  PokemonDetailUIModel? get pokemonDetailUIModel => _pokemonDetailUIModel;
  ValueNotifier<(ScreenState, bool?)> get isCaught => _isCaught;
  bool get showBack => _showBack;

  void updateShowBack() => _showBack = !_showBack;

  Future<void> getPokemon({
    required String name,
    required bool isShiny,
  }) async {
    _screenState.value = ScreenState.loading;
    final result = await _pokemonDetailDatasource.getPokemon(name);

    result.whenWithResult(
      (success) {
        log('success getPokemon ${success.value}');
        _pokemonDetailUIModel = success.value.toUIModel(
          isShiny,
        );
        _checkIsCaught();
        _screenState.value = ScreenState.idle;
      },
      (error) {
        log('error getPokemon $error');
        _screenState.value = ScreenState.error;
      },
    );
  }

  Future<void> caughtPokemon(BuildContext ctx) async {
    if (_pokemonDetailUIModel != null) {
      _isCaught.value = (ScreenState.loading, null);
      await locator<CaughtPokemonBloc>().caughtPokemon(
        pokemon: _pokemonDetailUIModel!.toCaughtPokeUIModel,
        onSuccess: () => CustomSnackBar.success(
          ctx: ctx,
          text: ctx.trl.snack_bar_caught_pokemon_success,
        ),
        onError: () => CustomSnackBar.error(
          ctx: ctx,
          text: ctx.trl.snack_bar_caught_pokemon_error,
        ),
      );
      await _checkIsCaught();
    }
  }

  Future<void> freePokemon(BuildContext ctx) async {
    if (_pokemonDetailUIModel != null) {
      _isCaught.value = (ScreenState.loading, null);
      await locator<CaughtPokemonBloc>().freePokemon(
        name: _pokemonDetailUIModel!.name,
        onSuccess: () => CustomSnackBar.success(
          ctx: ctx,
          text: ctx.trl.snack_bar_free_pokemon_success,
        ),
        onError: () => CustomSnackBar.error(
          ctx: ctx,
          text: ctx.trl.snack_bar_free_pokemon_error,
        ),
      );
      await _checkIsCaught();
    }
  }

  Future<void> _checkIsCaught() async {
    _isCaught.value = (ScreenState.loading, null);
    final result = await locator<CaughtPokemonBloc>()
        .isCaught(_pokemonDetailUIModel!.name);
    _isCaught.value = (ScreenState.idle, result);
  }
}
