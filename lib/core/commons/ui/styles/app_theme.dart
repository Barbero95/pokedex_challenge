import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';

// To create a theme color with only one primary (like on material3),
// set this line and substitute colorScheme for this parameter:
// colorSchemeSeed: ColorTheme.primary

class AppTheme {
  static ThemeData lightTheme({
    required ThemeModel themeModel,
    required Color color,
  }) =>
      ThemeData(
        colorScheme: CustomColors.light(color),
        useMaterial3: themeModel.useMaterial3,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          iconTheme: const IconThemeData(
            color: CustomColors.white,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: color,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? null
                : const IconThemeData(
                    color: CustomColors.white,
                  );
          }),
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: CustomColors.white,
            ),
          ),
        ),
      );

  static ThemeData darkTheme({
    required ThemeModel themeModel,
    required Color color,
  }) =>
      ThemeData(
        colorScheme: CustomColors.dark(color),
        useMaterial3: themeModel.useMaterial3,
        brightness: Brightness.dark,
      );
}
