import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/data/http/export_http.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/data/export_data.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/domain/model/export_model.dart';

class CaughtPokemonDatasourceImpl implements CaughtPokemonDatasource {
  final Box<CaughtPokemonModel> _pokemonBox = Hive.box(HiveKeys.caughtPokemon);

  @override
  Future<Result<List<CaughtPokemonModel>>> getCaughtPokemons() async {
    try {
      final list = _pokemonBox.values.cast<CaughtPokemonModel>().toList();
      return ResultSuccess(list);
    } catch (e, stackTrace) {
      debugPrint('Error get caught pokemons: $e');
      return ResultError(e, stackTrace);
    }
  }

  @override
  Future<Result<void>> addCaughtPokemon(
    CaughtPokemonModel pokemon,
  ) async {
    try {
      await _pokemonBox.put(pokemon.name, pokemon);
      debugPrint('Add caught pokemon');
      return ResultSuccess(null);
    } catch (e, stackTrace) {
      debugPrint('Error add caught pokemon: $e');
      return ResultError(e, stackTrace);
    }
  }

  @override
  Future<Result<void>> deleteCaughtPokemon(
    String name,
  ) async {
    try {
      await _pokemonBox.delete(name);
      debugPrint('Delete caught pokemon');
      return ResultSuccess(null);
    } catch (e, stackTrace) {
      debugPrint('Error delete caught pokemon: $e');
      return ResultError(e, stackTrace);
    }
  }

  @override
  Future<Result<bool>> isCaught(
    String name,
  ) async {
    try {
      return ResultSuccess(_pokemonBox.get(name) != null);
    } catch (e, stackTrace) {
      debugPrint('Error isCaught: $e');
      return ResultError(e, stackTrace);
    }
  }
}
