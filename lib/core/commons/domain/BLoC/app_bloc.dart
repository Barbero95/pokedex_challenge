import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:universal_io/io.dart';

class AppBloc {
  late final ValueNotifier<ThemeModel> _themeModel;
  AppBloc(Color color) {
    _themeModel = ValueNotifier(
      ThemeModel(
        useMaterial3: true,
        themeMode: ThemeMode.light,
        primaryColor: color,
      ),
    );
  }

  ValueNotifier<ThemeModel> get themeModel => _themeModel;

  bool useLightMode(
    BuildContext context,
  ) {
    switch (themeModel.value.themeMode) {
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void updateThemeMode(ThemeMode themeMode) =>
      _themeModel.value = themeModel.value.copyWith(themeMode: themeMode);

  void updateUseMaterial3() => _themeModel.value =
      themeModel.value.copyWith(useMaterial3: !_themeModel.value.useMaterial3);

  void updatePrimaryColor(Color color) {
    locator<SharedPreferencesService>().setPrimaryColor(color);
    _themeModel.value = themeModel.value.copyWith(primaryColor: color);
  }

  static bool isMobile(BoxConstraints constraints) =>
      Platform.isAndroid || Platform.isIOS || constraints.maxWidth <= 600;

  static Future<Color> loadPrimaryColorFromPrefs() async =>
      locator<SharedPreferencesService>().getPrimaryColor();
}
