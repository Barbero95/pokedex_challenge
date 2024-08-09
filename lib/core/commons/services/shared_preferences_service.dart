import 'dart:ui';

import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const String languageCode = 'languageCode';
  static const String primaryColor = 'primaryColor';
}

class SharedPreferencesService {
  SharedPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  Color getPrimaryColor() {
    final color = _preferences.getInt(_Keys.primaryColor);
    return color != null ? Color(color) : CustomColors.red;
  }

  void setPrimaryColor(Color primaryColor) =>
      _preferences.setInt(_Keys.primaryColor, primaryColor.value);

  // ==================== LANGUAGE METHODS ===================
  String getLanguageCode() =>
      _preferences.getString(_Keys.languageCode) ??
      TranslationsService.deviceLanguage.languageCode;

  Future<void> setLanguageCode(String languageCode) async =>
      _preferences.setString(_Keys.languageCode, languageCode);
  // ==================== END LANGUAGE METHODS ===================
}
