import 'package:flutter/material.dart';

class ThemeModel {
  final bool useMaterial3;
  final ThemeMode themeMode;
  final Color primaryColor;

  ThemeModel({
    required this.useMaterial3,
    required this.themeMode,
    required this.primaryColor,
  });

  ThemeModel copyWith({
    bool? useMaterial3,
    ThemeMode? themeMode,
    Color? primaryColor,
  }) {
    return ThemeModel(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
