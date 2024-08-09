import 'package:pokedex_code_challenge_21a/core/data/http/result.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/domain/model/export_model.dart';

abstract class CaughtPokemonDatasource {
  Future<Result<List<CaughtPokemonModel>>> getCaughtPokemons();
  Future<Result<void>> addCaughtPokemon(CaughtPokemonModel pokemon);
  Future<Result<void>> deleteCaughtPokemon(String name);
  Future<Result<bool>> isCaught(String name);
}
