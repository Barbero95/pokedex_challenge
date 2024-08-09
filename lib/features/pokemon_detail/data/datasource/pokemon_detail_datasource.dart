import 'package:pokedex_code_challenge_21a/core/data/http/result.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/domain/model/export_model.dart';

abstract class PokemonDetailDatasource {
  Future<Result<PokemonDetailResponse>> getPokemon(String name);
}
