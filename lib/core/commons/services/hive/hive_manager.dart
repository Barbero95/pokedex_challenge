import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/pokemon_type/export_pokemon_type.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/domain/model/export_model.dart';

class HiveKeys {
  static const String caughtPokemon = 'caught_pokemon';
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(CaughtPokemonModelAdapter())
    ..registerAdapter(PokemonTypeAdapter());
  await Hive.openBox<CaughtPokemonModel>(HiveKeys.caughtPokemon);
}
