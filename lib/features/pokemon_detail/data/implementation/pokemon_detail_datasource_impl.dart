import 'package:flutter/foundation.dart';
import 'package:pokedex_code_challenge_21a/core/data/http/export_http.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/data/export_data.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/domain/model/export_model.dart';

class _EndPoints {
  static const String getPokemons = '/pokemon';
}

class PokemonDetailDatasourceImpl implements PokemonDetailDatasource {
  @override
  Future<Result<PokemonDetailResponse>> getPokemon(String name) async {
    try {
      final response = await Api.requestHttp(
        endPoint: '${_EndPoints.getPokemons}/$name',
      );
      return ResultSuccess(PokemonDetailResponse.fromJson(response.body));
    } catch (e, stackTrace) {
      debugPrint('Error get pokemon: $e');
      return ResultError(e, stackTrace);
    }
  }
}
