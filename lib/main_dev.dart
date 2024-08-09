import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/environment/export_environment.dart';
import 'package:pokedex_code_challenge_21a/main_shared.dart';

class _Url {
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String mediaUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites';
}

class _Strings {
  static const String appTitle = 'Pokédex Challenge (Dev)';
}

Future<void> main() async {
  final Widget app = await initializeApp(
    EnvironmentConfig(
      environment: Environment.dev,
      variables: {
        EnvKeys.environment.name: Environment.dev,
        EnvKeys.baseUrl.name: _Url.baseUrl,
        EnvKeys.mediaUrl.name: _Url.mediaUrl,
        EnvKeys.appTitle.name: _Strings.appTitle,
      },
    ),
  );
  runApp(app);
}
