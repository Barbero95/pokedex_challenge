import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/environment/environment.dart';

class EnvironmentConfig {
  /// Type of flavor
  final Environment? environment;

  /// Color of the banner
  final Color color;

  /// Variables are dynamic
  final Map<String, dynamic> values;

  /// Factory constructor
  factory EnvironmentConfig({
    Environment? environment,
    Color color = Colors.red, // TO-DO: change to apptheme primaryColor
    Map<String, dynamic> variables = const {},
  }) {
    _instance = EnvironmentConfig._internal(
      environment,
      color,
      variables,
    );

    return _instance!;
  }

  /// Private constructor
  EnvironmentConfig._internal(
    this.environment,
    this.color,
    this.values,
  );

  /// Internal instance of EnvironmentConfig
  static EnvironmentConfig? _instance;

  /// Instance of EnvironmentConfig
  // ignore: prefer_constructors_over_static_methods
  static EnvironmentConfig get instance {
    _instance ??= EnvironmentConfig();

    return _instance!;
  }
}
