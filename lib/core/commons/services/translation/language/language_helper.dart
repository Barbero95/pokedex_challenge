import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/translation/language/export_language.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

class LanguageHelper {
  String mapLocaleToUI(
    String languageKey,
    BuildContext context,
  ) {
    switch (languageKey) {
      case LanguageKeys.english:
        return context.trl.language_english;
      case LanguageKeys.spanish:
        return context.trl.language_spanish;
      default:
        return context.trl.language_spanish;
    }
  }

  Locale mapLangKeyToLocale(String langKey) {
    switch (langKey) {
      case LanguageKeys.english:
        return LanguageLocales.english;
      case LanguageKeys.spanish:
        return LanguageLocales.spanish;
      default:
        return LanguageLocales.spanish;
    }
  }
}

final List<String> languagesListDefault = [
  LanguageKeys.english,
  LanguageKeys.spanish,
];
