import 'dart:convert';

import 'package:pokedex_code_challenge_21a/features/pokedex/domain/model/export_model.dart';

class PokedexResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<PokemonModel> results;

  PokedexResponse({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokedexResponse.fromMap(Map<String, dynamic> map) {
    return PokedexResponse(
      count: map['count'] as int? ?? 0,
      next: map['next'] as String?,
      previous: map['previous'] as String?,
      results: (map['results'] as List<dynamic>)
          .map((item) => PokemonModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory PokedexResponse.fromJson(String source) => PokedexResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'PokedexResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }
}
