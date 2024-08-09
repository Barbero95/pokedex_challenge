import 'package:pokedex_code_challenge_21a/core/data/http/result.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/domain/export_domain.dart';

abstract class PokedexDatasource {
  Future<Result<PokedexResponse>> getPokemons(PokedexRequest request);
}
