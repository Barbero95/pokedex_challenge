import 'package:flutter/foundation.dart';
import 'package:pokedex_code_challenge_21a/core/data/http/export_http.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/export_pokedex.dart';

class _EndPoints {
  static const String getPokemons = '/pokemon';
}

class PokedexDatasourceImpl implements PokedexDatasource {
  @override
  Future<Result<PokedexResponse>> getPokemons(PokedexRequest request) async {
    try {
      final response = await Api.requestHttp(
        endPoint: _EndPoints.getPokemons,
        params: request.toMap(),
      );
      return ResultSuccess(PokedexResponse.fromJson(response.body));
    } catch (e, stackTrace) {
      debugPrint('Error get pokemons: $e');
      return ResultError(e, stackTrace);
    }
  }
}
