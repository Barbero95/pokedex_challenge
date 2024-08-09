import 'package:flutter/foundation.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/environment/export_environment.dart';

class EnvironmentService {
  dynamic getValue(EnvKeys key) => EnvironmentConfig.instance.values[key.name];

  bool isDev() => (getValue(EnvKeys.environment) as Environment).isDev;
  bool isProd() => (getValue(EnvKeys.environment) as Environment).isProd;

  bool get isRelease => kReleaseMode;
  bool get isDebug => kDebugMode;
}
